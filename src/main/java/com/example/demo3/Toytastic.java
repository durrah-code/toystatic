package com.example.demo3;


import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.scene.web.WebView;
import javafx.stage.Stage;

public class Toytastic extends Application {

    @Override
    public void start(Stage primaryStage) {
        // Create a WebView to display HTML content
        WebView webView = new WebView();
        webView.getEngine().load(getClass().getResource("/index.html").toExternalForm()); // Load from resources

        // Create layout and scene
        StackPane root = new StackPane();
        root.getChildren().add(webView);
        Scene scene = new Scene(root, 800, 600);

        // Set up the stage
        primaryStage.setTitle("Toytastic - Children's Toy Store");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
