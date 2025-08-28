## About 
This PowerShell script provides two simple functions to detect user presence based on mouse movement. It can be used to trigger actions when a user arrives at or leaves their workstation.

`Target-Comes` – Continuously monitors the mouse cursor’s horizontal position. If the cursor remains stationary, it periodically sends a Caps Lock keypress as a placeholder action. When the cursor moves, the function stops, indicating the user has arrived.

`Target-Leaves` – Monitors the cursor position over a specified interval (in seconds). If the cursor does not move during the interval, it concludes the user has left the workstation.

## Usage
`Target-Comes`

`Target-Leaves -Seconds 10`
