{ config, ... }:

{
  users.motd = ''
     ______________________________   ______________
    / ______________________/ ___/ | / / ____/_  __/
    \__ \/ __ \/ __ \/ __ \/ /__/  |/ / __/   / /
   ___/ / / / / /_/ / /_/ / ___/ /|  / /___  / /
  /____/_/ /_/\____/\____/_/  /_/ |_/_____/ /_/
  
  Current system: ${networking.hostName}.
  Fingers crossed it's not that broken this time.
  '';
  # TODO:
  # - list total resources?
  # - list status of the machine(errors, working well, etc)
  # - print purpose of the machine
  # - print a notice if the machine is currently running jobs or at high resource usage
}