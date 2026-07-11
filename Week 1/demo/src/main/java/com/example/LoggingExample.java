package com.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingExample {
    // Initialize the SLF4J Logger for this specific class
    private static final Logger logger = LoggerFactory.getLogger(LoggingExample.class);

    public static void main(String[] args) {
        // Log messages at different severity levels
        logger.error("This is an error message");
        logger.warn("This is a warning message");
        
        System.out.println("\nSLF4J Logging execution finished!");
    }
}
