package com.streaming;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.sql.*;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;

import net.snowflake.ingest.streaming.InsertValidationResponse;
import net.snowflake.ingest.streaming.OpenChannelRequest;
import net.snowflake.ingest.streaming.SnowflakeStreamingIngestChannel;
import net.snowflake.ingest.streaming.SnowflakeStreamingIngestClient;
import net.snowflake.ingest.streaming.SnowflakeStreamingIngestClientFactory;

public class App {
  // Please follow the example in snowflake_account_config.properties to see the
  // required properties, or
  // you will need the rsa private key to run this demo. You can setup key-pair
  // using this link
  // https://docs.snowflake.com/en/user-guide/key-pair-auth#configuring-key-pair-authentication
  // Paste your private key in the properties file in a single line, do not
  // include begin and end lines

  final static String CONFIG_PATH = "C:/Projects/BNYM/POC_Streaming/workspace/snowpipe-streaming-api-demo-main/snowpipe-streaming-api-demo-main/streaming-data-ingestion/snowflake_account_config.properties";
  final static String inputFile = "C:/Projects/BNYM/POC_Streaming/workspace/snowpipe-streaming-api-demo-main/snowpipe-streaming-api-demo-main/streaming-data-ingestion/emp.txt";

  public static void main(String[] args) throws Exception {
    Properties props = new Properties();
    System.out.println("Inside main");
    // System.out.println(new
    // File("snowflake_account_config.properties").getAbsoluteFile());
    InputStream propStream = new FileInputStream(CONFIG_PATH);
    props.load(propStream);
    System.out.println(props.getProperty("private_key"));

    // Create a streaming ingest client
    try (SnowflakeStreamingIngestClient client = SnowflakeStreamingIngestClientFactory
        .builder(props.getProperty("private_key")).setProperties(props).build()) {

      // Create an open channel request on table MY_TABLE, note that the corresponding
      // db/schema/table needs to be present
      // Example: create or replace table MY_TABLE(c1 number);
      System.out.println("key loaded");
      OpenChannelRequest request1 = OpenChannelRequest.builder(props.getProperty("channel"))
          .setDBName(props.getProperty("database"))
          .setSchemaName(props.getProperty("schema"))
          .setTableName(props.getProperty("table"))
          .setOnErrorOption(
              OpenChannelRequest.OnErrorOption.CONTINUE) // Another ON_ERROR option is ABORT
          .build();
      System.out.println("req details" + request1.getDBName() + request1.getSchemaName() + request1.getTableName());
      // Open a streaming ingest channel from the given client
      SnowflakeStreamingIngestChannel channel1 = client.openChannel(request1);

      // Insert rows into the channel (Using insertRows API)

      // connecting to my sql
      String url = "jdbc:mysql://127.0.0.1:3306/world";
      String user = "root";
      String password = "27&Jan2024";
      int totalRowsInTable = 0;
      DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      // Date date = new Date();
      Date date1 = new Date();
      ;

      try {
        Connection conn = DriverManager.getConnection(url, user, password);
        Statement stmt = conn.createStatement();
        Date date = new Date();
        System.out.println("Started Retrieving data from mysql: " + dateFormat.format(date));
        ResultSet rs = stmt.executeQuery("SELECT * FROM world.city LIMIT 100");

        // date1 = new Date();
        System.out.println("Started loading data into Snowflake table at: ");
        System.out.println(dateFormat.format(date1));
        while (rs.next()) {
          int id = rs.getInt("ID");
          String name = rs.getString("Name");
          String countryCode = rs.getString("CountryCode");

          System.out.println("records from my sql -----> " + id + name + countryCode);

          Map<String, Object> row = new HashMap<>();

          // mapping the values in snowflake
          row.put("ID", rs.getInt("ID"));
          row.put("NAME", rs.getString("Name"));
          row.put("CountryCode", rs.getString("CountryCode"));
          row.put("District", rs.getString("District"));
          row.put("Population", rs.getInt("Population"));
          totalRowsInTable++;

          // this is for file input starts
          // String read=null;
          // BufferedReader in = new BufferedReader(new FileReader(inputFile));
          // InsertValidationResponse response=null;
          // while ((read = in.readLine()) != null) {
          // String[] splited = read.split(",");
          // System.out.println(splited[0]+splited[1]+splited[2]+splited[3]);
          // row.put("EMP_ID",splited[0]);
          // row.put("NAME",splited[1]);
          // row.put("DEPARTMENT",splited[2]);
          // row.put("SALARY",splited[3]);
          // //Insert the records with current offset token
          // response = channel1.insertRow(row, String.valueOf(totalRowsInTable));
          // totalRowsInTable ++;
          // }
          // in.close();
          // file input ends

          // Insert the row with the current offset_token
          InsertValidationResponse response = channel1.insertRow(row, String.valueOf(totalRowsInTable));
          if (response.hasErrors()) {
            // Simply throw if there is an exception, or you can do whatever you want with
            // the
            // erroneous row
            throw response.getInsertErrors().get(0).getException();
          }
          // totalRowsInTable++;
        } // closing while rs loop

      } catch (Exception ex) {
        System.err.println("An error occurred while connecting to the database: " + ex.getMessage());
      }

      Date date2 = new Date();
      System.out.println("\n" + "Completed Streaming data into Snowflake at: " + dateFormat.format(date2));

      long secondsBetween = (date2.getTime() - date1.getTime()) / 1000;
      System.out.println("Total Streaming time: " + secondsBetween + " Secs for " + totalRowsInTable + " Rows");

      // If needed, you can check the offset_token registered in Snowflake to make
      // sure everything
      // is committed
      final int expectedOffsetTokenInSnowflake = totalRowsInTable - 1; // 0 based offset_token
      final int maxRetries = 100;
      int retryCount = 0;
      Date date3 = new Date();

      do {
        String offsetTokenFromSnowflake = channel1.getLatestCommittedOffsetToken();
        // System.out.println("offset token is " + offsetTokenFromSnowflake);
        if (offsetTokenFromSnowflake != null
            && offsetTokenFromSnowflake.equals(String.valueOf(expectedOffsetTokenInSnowflake))) {
          date3 = new Date();
          System.out.println("SUCCESSFULLY inserted " + totalRowsInTable + " rows at " + dateFormat.format(date3));
          break;
        }
        retryCount++;
      } while (retryCount < maxRetries);

      // Close the channel, the function internally will make sure everything is
      // committed (or throw
      // an exception if there is any issue)
      channel1.close().get();

    }
  }

}