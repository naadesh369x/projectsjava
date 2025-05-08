package com.example.demo.utils;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileHandler {

    private static final String FILE_PATH = "users.txt"; // Unified storage

    public static boolean isFileExist(String fileName) {
        return new File(fileName).exists();
    }

    public static boolean createFile(String fileName) {
        try {
            return new File(fileName).createNewFile();
        } catch (IOException e) {
            System.out.println("Error creating file: " + fileName);
            return false;
        }
    }

    public static boolean writeToFile(String fileName, boolean append, String data) {
        if (!isFileExist(fileName)) {
            if (!createFile(fileName)) return false;
        }
        try (FileWriter writer = new FileWriter(fileName, append)) {
            writer.write(data);
            return true;
        } catch (IOException e) {
            System.out.println("Write error: " + e.getMessage());
            return false;
        }
    }

    public static String[] readFromFile(String fileName) {
        if (!isFileExist(fileName)) return new String[0];

        StringBuilder data = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                data.append(line).append("\n");
            }
        } catch (IOException e) {
            System.out.println("Read error: " + e.getMessage());
        }
        return data.toString().isEmpty() ? new String[0] : data.toString().split("\n");
    }

    public static boolean updateCredentials(String currentEmail, String newEmail, String newPassword, String role) {
        File file = new File(FILE_PATH);
        if (!file.exists()) return false;

        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3 && parts[0].equals(currentEmail) && parts[2].equals(role)) {
                    lines.add(newEmail + "," + newPassword + "," + role);
                    updated = true;
                } else {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (!updated) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : lines) {
                writer.write(updatedLine);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }





    public static void removeLineContaining(String keyword) {
        File file = new File(FILE_PATH);
        List<String> updatedLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.contains(keyword)) {
                    updatedLines.add(line);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static boolean savePropertiesToFile(List<com.example.demo.models.Property> properties) {
        String filePath = "properties.txt";
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (com.example.demo.models.Property p : properties) {
                String line = String.join(",",
                        p.getId(),
                        p.getTitle(),
                        p.getLocation(),
                        String.valueOf(p.getPrice()),
                        p.getType(),
                        p.getDescription().replace(",", " "),
                        String.valueOf(p.getRadius()),
                        p.getImageFileName() == null ? "" : p.getImageFileName(),
                        p.getSellerPhone() == null ? "" : p.getSellerPhone()
                );
                writer.write(line);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.out.println("Error saving properties: " + e.getMessage());
            return false;
        }
    }

    // Always return unified file
    public static String getFilePathByRole(String role) {
        return FILE_PATH;
    }


    public static boolean deleteUserByEmail(String email) {
        File file = new File(FILE_PATH);
        if (!file.exists()) return false;

        List<String> updatedLines = new ArrayList<>();
        boolean deleted = false;

        String[] lines = readFromFile(FILE_PATH);
        for (String line : lines) {
            String[] parts = line.split(",");
            if (parts.length == 3) {
                String fileEmail = parts[0].trim();
                if (fileEmail.equalsIgnoreCase(email.trim())) {
                    deleted = true; // Match found, skip this line (i.e., delete)
                    continue;
                }
            }
            updatedLines.add(line);
        }

        if (!deleted) return false;

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String updatedLine : updatedLines) {
                writer.write(updatedLine);
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}

