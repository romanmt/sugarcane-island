start "You are on an island, and you're thirsty.", :find_water

step :find_water,
  "You begin looking for water.", 
  :stream_or_drive_through

choose :stream_or_drive_through, 
  "Your hear the sounds of running water, do you want to find the stream or look for a drive through?", 
  :stream, :drive_through

finish :stream, "You found water, quench your thirst."

finish :drive_through, "You have died."

