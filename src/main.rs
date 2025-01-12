use axum::{
    routing::get,
    Router,
};
use std::net::SocketAddr;

#[tokio::main]
async fn main() {
    // Build the application with a single route
    let app = Router::new().route("/", get(handler));

    // Define the address and port for the server
    let addr = SocketAddr::from(([0, 0, 0, 0], 8080)); // Change to 0.0.0.0
    println!("Listening on http://{}", addr);

    // Start the server
    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

// Define a handler for the root route
async fn handler() -> &'static str {
    "Hello, world!"
}
