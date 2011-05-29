# Google Tasks

This gem provides access to google tasks apis

## Install

``` sh
$ gem install google_tasks
```

## Usage

Before start you need **client_id**, **client_secret** and **api_key**, you found it [here](https://code.google.com/apis/console)

``` rb
google_tasks = GoogleTasks.new('client_id', 'client_secret', 'api_key')
google_tasks.lists.items.map(&:title) # => ["List 1", "List 2", "List 3"]
list_id = google_tasks.list.first.id
google_tasks.lists(:delete, list_id)
tasks = google_tasks.tasks(:list, list_id)
```

You can find more information on [Api Explorer](http://code.google.com/apis/explorer/#_s=tasks&_v=v1)