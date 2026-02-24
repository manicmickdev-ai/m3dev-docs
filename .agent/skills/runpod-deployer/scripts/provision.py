import runpod
import argparse
import os
import sys

# Ensure API Key is present
if not os.getenv("RUNPOD_API_KEY"):
   print("Error: RUNPOD_API_KEY environment variable not set.")
   sys.exit(1)

def provision_pod(gpu_type):
   print(f"Provisioning {gpu_type} on RunPod...")
   try:
       # Note: In a real scenario, you would map "RTX 3090" to specific device IDs
       pod = runpod.create_pod(
           name="Agent-Provisioned-Worker",
           image_name="runpod/pytorch:2.0.1-cuda11.8-cudnn8-devel",
           gpu_type_id=gpu_type, 
           cloud_type="SECURE",
           container_disk_in_gb=40
       )
       print(f"Success! Pod ID: {pod['id']}")
       print(f"Status: {pod}")
   except Exception as e:
       print(f"Failed to provision pod: {e}")

if __name__ == "__main__":
   parser = argparse.ArgumentParser()
   parser.add_argument("--gpu", type=str, default="NVIDIA GeForce RTX 3090", help="GPU Type ID")
   args = parser.parse_args()
   provision_pod(args.gpu)
