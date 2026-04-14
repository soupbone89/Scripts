#!/usr/bin/env python3

import subprocess
import sys
import time
from pathlib import Path

# config - change these if you want
TARGETS_FILE = "targets.txt"
RATE = 500                  # threads (300-600 is usually fine)
MAX_LOAD = 5.75
COOL_DOWN = 3.45
PORTS = "80,443,22,21,8080,5900,554,3389,23,1883"

def load_cidrs(file_path):
    path = Path(file_path)
    if not path.exists():
        print(f"Error: {file_path} not found!")
        sys.exit(1)
    
    cidrs = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#"):
                cidrs.append(line)
    return cidrs


def run_scan(cidr):
    print(f"\n=== Starting scan for: {cidr} ===\n")

    cmd = [
        sys.executable,
        "execution/scanner.py",
        "--target", cidr,
        "--rate", str(RATE),
        "--max-load", str(MAX_LOAD),
        "--cool-down", str(COOL_DOWN),
        "--ports", PORTS,
    ]

    try:
        result = subprocess.run(cmd, check=True)
        print(f"Finished scanning {cidr} (exit code {result.returncode})")
    except subprocess.CalledProcessError as e:
        print(f"Scan failed for {cidr} (exit code {e.returncode})")
    except FileNotFoundError:
        print("Could not find execution/scanner.py - make sure you are in the project root.")
        sys.exit(1)
    except KeyboardInterrupt:
        print("\nInterrupted by user.")
        sys.exit(130)


def main():
    cidrs = load_cidrs(TARGETS_FILE)
    if not cidrs:
        print("No valid CIDRs found in targets.txt")
        sys.exit(1)

    print(f"Found {len(cidrs)} CIDRs to scan.\n")

    for i, cidr in enumerate(cidrs, 1):
        print(f"[{i}/{len(cidrs)}] Processing {cidr}")
        run_scan(cidr)
        
        if i < len(cidrs):
            print("Waiting 5 seconds before next target...\n")
            time.sleep(5)

    print("\nAll targets processed!")
    print("Results are stored in the project's database.")
    print("Run `deepfocus` and type `/stop` to export everything to a .txt file.")


if __name__ == "__main__":
    main()
