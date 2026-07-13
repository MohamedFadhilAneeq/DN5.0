package com.cognizant.account.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import com.cognizant.account.Account;

@RestController
public class AccountController {

    @GetMapping("/accounts/{number}")
    public Account getAccount(@PathVariable String number) {
        // Returning a dummy response without any backend connectivity
        return new Account(number, "savings", 234343); 
    }
}