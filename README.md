# Redmine Enforce Time Entry

Allows forcing users to log time on issue update for configurable conditions. Conditions can be set globally or
per project. Project settings override global settings.

This plugin is compatible with Redmine 4.x. If you want to use it with Redmine 3.x please use redmine3 branch.


## Features

Enforcing can happen

* on any update or when issue status changes, configurable
* when issue status was any one of configured statuses
* when issue status will be any one of configured statuses


## Settings

Go to project setting page for projects that you want to enable enforcing, enable the module in the modules section. You should now see
the settings tab for Enforce Time Entry. Users with permission `edit_project` can also see the configuration tab.
Configure your preferences. Note that you can select / unselect multipe values by clicking with mouse button
while holding the Ctrl key. Also after clicking one of the status boxes (multi selects) Ctrl-A will select all.

When an issue is updated, assume issue status is X and it is changed to Y. The user will be required to enter Spent Time when
"Previous Issue Status" setting include X or "New Issue Status setting include Y". If "Only on Issue Status Changes" is not selected
and issue status does not change during update we still check if the status is one of Previous or New Issue Status configured.

If you want to skip enforcing for some users, you can give their roles 'Can Skip Log Time' permission. Note
that Admin users have all the permissions by default, including 'Can Skip Log Time', so Admin users will not be forced to enter
spent time.

Loggable hours by a user per day can also be defined in the settings, which will prevent users to log more hours than configured. You can for example
prevent users to log more than 24 hours per day.


## License

Copyright (c) 2016 - 2020 Onur Küçük. Licensed under [GNU GPLv2](LICENSE)

