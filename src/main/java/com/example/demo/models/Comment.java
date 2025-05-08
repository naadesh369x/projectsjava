package com.example.demo.models;



public class Comment {
    private String userEmail;
    private String text;
    private int rating;
    private String propertyId;

    public Comment() {
    }

    public Comment(String userEmail, String text, int rating, String propertyId) {
        this.userEmail = userEmail;
        this.text = text;
        this.rating = rating;
        this.propertyId = propertyId;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(String propertyId) {
        this.propertyId = propertyId;
    }
}
