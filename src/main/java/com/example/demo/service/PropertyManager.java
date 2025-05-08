package com.example.demo.service;

import com.example.demo.models.Property;
import com.example.demo.utils.FileHandler;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class PropertyManager {
    private static List<Property> properties = null;
    private static final String fileName = "properties.txt";

    // Load properties from file if not already loaded
    public static void readProperties() {
        if (properties != null)
            return;

        properties = new ArrayList<>();
        String[] data = FileHandler.readFromFile(fileName);

        for (String record : data) {
            String[] fields = record.split(";");
            if (fields.length >= 11) {
                String id = fields[0];
                String title = fields[1];
                String location = fields[2];
                String type = fields[3];
                double price = parseDouble(fields[4]);
                double radius = parseDouble(fields[5]);
                String description = fields[6];
                String imageFileName = fields[7];
                String bookedBy = fields[8];
                String sellerEmail = fields[9];
                String sellerPhone = fields[10];

                Property property = new Property(id, title, location, type, price, radius, description, imageFileName, bookedBy, sellerEmail,sellerPhone);
                properties.add(property);
            }
        }
    }

    // Add a new property
    public static void addProperty(Property property) {
        if (properties == null) readProperties();

        // Assign unique ID if not present
        if (property.getId() == null || property.getId().isEmpty()) {
            property.setId(UUID.randomUUID().toString());
        }

        properties.add(property);
        FileHandler.writeToFile(fileName, true, property.toFileString());
    }

    // Update an existing property
    public static boolean updateProperty(Property updatedProperty) {
        if (properties == null) readProperties();

        for (int i = 0; i < properties.size(); i++) {
            if (properties.get(i).getId().equals(updatedProperty.getId())) {
                properties.set(i, updatedProperty);
                break;
            }
        }
        savePropertiesToFile();
        return false;
    }

    // Delete property by ID
    public static void removeProperty(String id) {
        if (properties == null) readProperties();

        properties.removeIf(p -> p.getId().equals(id));
        savePropertiesToFile();
    }

    // Get all properties
    public static List<Property> getProperties() {
        if (properties == null) readProperties();
        return properties;
    }
    public Property getPropertyById(String id) {
        List<Property> allProperties = getProperties();
        for (Property p : allProperties) {
            if (p.getId().equals(id)) {
                return p;
            }
        }
        return null;
    }
    public List<String> getCommentsByPropertyId(String propertyId) {
        // Read from a file like "comments_<propertyId>.txt" or a shared file with mappings
        List<String> comments = new ArrayList<>();
        // ... implement reading logic here
        return comments;
    }



    // Get properties filtered by seller email
    public static List<Property> getPropertiesBySeller(String sellerEmail) {
        if (properties == null) readProperties();

        List<Property> result = new ArrayList<>();
        for (Property p : properties) {
            if (p.getSellerEmail() != null && p.getSellerEmail().equals(sellerEmail)) {
                result.add(p);
            }
        }
        return result;
    }

    // Find property by ID
    public static Property findPropertyById(String id) {
        if (properties == null) readProperties();

        for (Property p : properties) {
            if (p.getId().equals(id)) {
                return p;
            }
        }
        return null;
    }
    public void addCommentToProperty(String propertyId, String comment) {
        // Save comment to file or in memory list (e.g., propertyId_comments.txt)
    }


    // Save all properties to the file (overwrite)
    public static void savePropertiesToFile() {
        if (properties == null) return;

        StringBuilder allProps = new StringBuilder();
        for (Property property : properties) {
            allProps.append(property.toFileString());
        }
        FileHandler.writeToFile(fileName, false, allProps.toString());
    }

    // Safe double parser
    private static double parseDouble(String value) {
        try {
            return Double.parseDouble(value);
        } catch (Exception e) {
            return 0.0;
        }
    }
}
