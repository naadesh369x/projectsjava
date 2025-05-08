package com.example.demo.bst;


import com.example.demo.models.Property;

public class PropertyNode {
    public int key;
    public Property data;
    public PropertyNode left;
    public PropertyNode right;

    public PropertyNode(int key, Property data) {
        this.key = key;
        this.data = data;
    }
}
