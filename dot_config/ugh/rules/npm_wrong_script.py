from thefuck.specific.npm import npm_available, get_scripts
from thefuck.utils import for_app

enabled_by_default = npm_available

@for_app('npm')
def match(command):
    return ('Unknown command: ' in command.output and 'Did you mean this?' in command.output)

def get_new_command(command):
    output_lines = command.output.split('\n')
    suggestion_lines = []
    suggestion_section = False
    for line in output_lines:
        if line.startswith('Did you mean this?'):
            suggestion_section = True
            continue
        if suggestion_section:
            if line.strip() == '' or line.startswith('To see a list of supported npm commands'):
                break
            suggestion_lines.append(line.strip())

    if len(suggestion_lines) > 0:
        # Take the first suggestion
        first_suggestion = suggestion_lines[0]
        suggested_command = first_suggestion.split('#')[0].strip().replace('npm ', '')
        return command.script.replace(command.script.split()[1], suggested_command)
    
    return command.script