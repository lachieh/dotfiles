import re


def match(command):
    return command.script.startswith('claude') and 'claude --resume' in command.output


def get_new_command(command):
    for line in reversed(command.output.splitlines()):
        m = re.search(r'claude --resume\s+([\w-]+)', line)
        if m:
            return 'claude --resume {}'.format(m.group(1))
    return None
