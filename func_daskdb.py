import docker
import os

def handle():
    # Initialize Docker client
    print("Init docker client")
    client = docker.DockerClient(base_url='unix://var/run/docker.sock')
    print(os.getcwd())
    # Specify the container ID and script to execute
    container_id = "940ce6eca0e2"
    script_path = "/home/DaskDB_docker_build/SSTD_Queries_dask_1_node.py"

    try:
        # Fetch the container
        print("fetching container")
        container = client.containers.get(container_id)

        # Execute the script inside the container
        print("executing inside container")
        exec_result = container.exec_run(f"python {script_path}", workdir="/")

        print("results")
        print(exec_result)
        # Output the result
        return {"message": f"Script executed with exit code {exec_result.exit_code}", "output": exec_result.output.decode('utf-8')}
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    handle()
