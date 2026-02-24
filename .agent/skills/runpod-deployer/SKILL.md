---
name: runpod-deployer
description: Provisions GPU infrastructure on RunPod. Use when the user asks to "deploy a GPU", "start a pod", or "get compute".
---

# RunPod Infrastructure Deployer

## Goal

Provision a secure, reproducible GPU environment using the RunPod Python SDK.

## Capability

This skill utilizes the `scripts/provision.py` script to interact with the RunPod API.

## Usage Process

   1. **Identify Requirements**: Ask the user for the preferred GPU type (e.g., "RTX 3090", "A100") if not specified.
   2. **Execute Provisioning**:

* Run the script: `python .agent/skills/runpod-deployer/scripts/provision.py --gpu <type>`

   1. **Return Credentials**: The script will output the POD ID and SSH connection string. Display these clearly to the user.

## Constraints

* Always use the `runpod/pytorch:2.0.1-cuda11.8-cudnn8-devel` image unless instructed otherwise.
* Ensure the RunPod API Key is loaded from the environment variable `RUNPOD_API_KEY`. Do not hardcode keys.
