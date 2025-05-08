package com.example.demo.models;

public class Seller extends User {

    public Seller(String email, String password) {
        super(email, password, "seller"); // Assign the role "seller"
    }

    // Additional functionality specific to Seller can be added here
    // Example: methods to manage properties
}
