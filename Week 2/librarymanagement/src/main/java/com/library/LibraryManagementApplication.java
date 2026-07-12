package com.library;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import com.library.service.BookService;

public class LibraryManagementApplication {
    public static void main(String[] args) {
        // Load the Spring context from the XML file
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");

        // Ask Spring for the fully built BookService (no 'new' keyword needed!)
        BookService service = (BookService) context.getBean("bookService");

        // Test if everything is connected
        service.manageBooks();
    }
}