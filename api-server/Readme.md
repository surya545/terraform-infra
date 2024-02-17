## Flask App with Health API

This Flask application contains a simple health API endpoint. It is organized using blueprints for modularity and easy maintenance.

### Project Structure

- **api-server/**: Root directory of the Flask application.
    - **src/**: Source code directory.
        - **routes/**: Directory for defining API routes.
            - **\_\_init\_\_.py**: Initialization file for routes module.
            - **health.py**: Blueprint for the health API.
        - **\_\_init\_\_.py**: Initialization file for the Flask application.
    - **requirements.txt**: File containing the dependencies required for the application.
    - **run.py**: Main entry point for running the Flask application.

### Routes

- **Health API**:
    - Endpoint: `/health`
    - Description: Provides information about the health status of the application.

