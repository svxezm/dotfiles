#!/bin/bash

MESSAGE_FILE="$HOME/boot/boot_message.txt"
DISPLAYED_FILE="$HOME/boot/last_displayed_message.txt"

# Check if there's a message file
if [ -f "$MESSAGE_FILE" ]; then
  # Read the new message
  NEW_MESSAGE=$(cat "$MESSAGE_FILE")

  # Compare with the last displayed message
  if [ ! -f "$DISPLAYED_FILE" ] || [ "$NEW_MESSAGE" != "$(cat "$DISPLAYED_FILE")" ]; then
    echo "$NEW_MESSAGE"

    # Update the last displayed message
    echo "$NEW_MESSAGE" > "$DISPLAYED_FILE"
  fi
fi
