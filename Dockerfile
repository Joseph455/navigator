FROM osrf/ros:noetic-desktop-full

# Set working directory
WORKDIR /catkin_ws/

# Update and upgrade packages
RUN apt update -y && apt upgrade -y && apt install -y \
    python3-rosdep python3-rosinstall python3-rosinstall-generator \
    python3-wstool build-essential python3-venv ros-noetic-turtlebot3-description \
    curl bash gcc python3-dev musl-dev

# Install uv
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:0.4.15 /uv /bin/uv

# Place executables in the environment at the front of the path
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
ENV PATH="/catkin_ws/.venv/bin:$PATH"

# Compile bytecode
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

# uv Cache
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#caching
ENV UV_LINK_MODE=copy

# Copy the source code
COPY ./catkin_ws/src /catkin_ws/src

COPY ./catkin_ws/src/dqnTurtlebot/pyproject.toml /catkin_ws/
COPY ./catkin_ws/src/dqnTurtlebot/uv.lock /catkin_ws/
COPY ./catkin_ws/src/dqnTurtlebot/.python-version /catkin_ws/

# Install dependencies
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=/catkin_ws/src/dqnTurtlebot/uv.lock,target=/catkin_ws/src/dqnTurtlebot/uv.lock \
    --mount=type=bind,source=/catkin_ws/src/dqnTurtlebot/pyproject.toml,target=/catkin_ws/src/dqnTurtlebot/pyproject.toml \
    uv sync --frozen --no-install-project


ENV PYTHONPATH=/catkin_ws
ENV UV_HTTP_TIMEOUT=10000
ENV TURTLEBOT3_MODEL=burger

RUN cd /catkin_ws/

# Initialize rosdep
RUN sudo rosdep update

# Build the workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make -DPYTHON_EXECUTABLE=/usr/bin/python3"
