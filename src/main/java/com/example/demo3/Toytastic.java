package com.example.demo3;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

/**
 * Main entry point for the Toytastic application.
 * Launches the primary stage and sets up the main scene.
 */
public class Toytastic extends Application {
    @Override
    public void start(Stage primaryStage) {
        // Set up the main scene
        StackPane root = new StackPane();
        Scene scene = new Scene(root, 800, 600);

        primaryStage.setTitle("Toytastic - Children's Toy Store");
        primaryStage.setScene(scene);
        primaryStage.show();

        // You can load other scenes or controllers here for different sections
    }

    public static void main(String[] args) {
        launch(args);
    }
}
