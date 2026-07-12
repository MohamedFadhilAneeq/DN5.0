package com.library.service;

import com.library.repository.BookRepository;

public class BookService {
    // We do NOT use the 'new' keyword here. Spring will inject this for us!
    private BookRepository bookRepository;

    // Setter method required for Spring Dependency Injection (Exercise 2)
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    public void manageBooks() {
        System.out.println("BookService: Managing library books...");
        // Call the repository method to prove it was injected successfully
        bookRepository.fetchBooks();
    }
}