# Drone Navigation Agent using Q-Learning


### Prerequisites

- Ensure that [Docker](https://docs.docker.com/get-docker/) is installed on your mach
This project implements a deep reinforcement learning framework to train a drone navigation agent using Q-Learning, simulated in a ROS-1 environment. It is based on the [dqnTurtlebot](https://github.com/sgawalsh/dqnTurtlebot) repository and serves as a submission for a term project.

## Project Purpose

The primary objective of this project is to develop a Deep Q-Learning model capable of training a neural network to control a drone for obstacle navigation. The simulation is conducted within a ROS-1 environment, providing a realistic testing and development setup.

## Getting Started with Docker

Follow the steps below to set up and run the project using Docker.ine.

### Setup Instructions

1. **Clone the Repository**
   
   ```bash
   git clone https://github.com/Joseph455/navigator
   cd navigator
   ```

2. **Build the Docker Image**

   ```bash
   docker compose build
   ```

3. **Run the Agent**
   
   **Note:** The container runs the Gazebo GUI client, which requires adding it to the X11 user list on Linux.
   
   **Note:** Running the container on Windows has not been tested.
   
   ```bash
   xhost +local:docker
   ```

   Start the Docker container:
   
   ```bash
   docker compose up
   ```

   This command launches the container and initializes the Gazebo simulation environment.

4. **Access the Container**
   
   Enter the container environment to complete the setup:
   
   ```bash
   docker exec -it navigator-ros-1 bash
   ```

5. **Configure the Environment**
   
   Source the ROS configuration:
   
   ```bash
   source ./devel/setup.bash
   ```
   
   Navigate to the bot directory:
   
   ```bash
   cd ./src/dqnTurtlebot/
   ```

6. **Install Dependencies** (If running for the first time)
   
   Install Python dependencies using `uv`:
   
   ```bash
   uv sync
   ```

   Activate the virtual environment:
   
   ```bash
   source ./.venv/bin/activate
   ```

7. **Run the Simulation**
   
   Start the training simulation:
   
   ```bash
   rosrun turt_q_learn turt_q_learn_hypers.py
   ```

## Additional Information

- **Requirements:** The project requires ROS (Robot Operating System) within the Docker container. The Dockerfile is configured to handle all necessary dependencies.


## Acknowledgments

This project is a term project submission based on the [dqnTurtlebot](https://github.com/sgawalsh/dqnTurtlebot) repository. Special thanks to the original authors for their foundational work.
