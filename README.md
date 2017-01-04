# Redmine Enforce Time Entry

Allows forcing users to log time on issue update for configurable conditions. Conditions can be set per project.

## Features

Enforcing can happen

* on any update or when issue status changes, configurable
* when issue status was any one of configured statuses
* when issue status will be any one of configured statuses

If you want some users to be able to bypass enforcing, you can give their roles 'Can Skip Log Time' permission.

## Settings

Go to project setting page for projects that you want to enable enforcing, enable the module in the modules section. You should now see
the settings tab for Enforce Time Entry. Configure your preferences. Note that you can select / unselect multipe values by clicking with mouse button
while holding the Ctrl key. Also after clicking one of the status boxes (multi selects) Ctrl-A will select all.

