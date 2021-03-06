const { spawn } = require("child_process");
export function pbcopy(data) {
  var proc = spawn("pbcopy");
  proc.stdin.write(data);
  proc.stdin.end();
}
