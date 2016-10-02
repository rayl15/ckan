# Copyright 2014-2015 Boxkite Inc.

# This file is part of the DataCats package and is released under
# the terms of the GNU Affero General Public License version 3.0.
# See LICENSE.txt or http://www.fsf.org/licensing/licenses/agpl-3.0.html

from datacats.environment import Environment


def shell(environment, opts):
    """Run a command or interactive shell within this environment

Usage:
  datacats [-d] [-s NAME] shell [ENVIRONMENT [COMMAND...]]

Options:
  -d --detach       Run the resulting container in the background
  -s --site=NAME   Specify a site to run the shell on [default: primary]

ENVIRONMENT may be an environment name or a path to an environment directory.
Default: '.'
"""
    environment.require_data()
    environment.start_supporting_containers()
    return environment.interactive_shell(
        opts['COMMAND'],
        detach=opts['--detach']
    )


def paster(opts):
    """Run a paster command from the current directory

Usage:
  datacats paster [-d] [-s NAME] [COMMAND...]

Options:
  -s --site=NAME   Specify a site to run this paster command on [default: primary]
  -d --detach       Run the resulting container in the background

You must be inside a datacats environment to run this. The paster command will
run within your current directory inside the environment. You don't need to
specify the --plugin option. The --config option also need not be specified.
"""
    environment = Environment.load('.')
    environment.require_data()
    environment.start_supporting_containers()

    if not opts['COMMAND']:
        opts['COMMAND'] = ['--', 'help']

    assert opts['COMMAND'][0] == '--'
    return environment.interactive_shell(
        opts['COMMAND'][1:],
        paster=True,
        detach=opts['--detach']
        )
