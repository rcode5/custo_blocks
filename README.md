Overview
========

This is a sample app that shows how you build custom fields on ActiveRecord objects using ActiveRecord::Store.

For the write up, check out http://rcode5.wordpress.com

This project came out of a CMS system I was building where we needed to make a simple display widget which could, for different widget types, have different parameters.  Each widget needed a different layout.  We wanted and easy system for a front-end savy developer to add widgets with they're layouts, and still let the CMS user easily add new widgets.  We solved that (as shown in this sample app) by allowing the widget to be configured via a Yaml file and a partial (for display).  Because we store this along with all other widgets, we re-use the same controllers/edit forms (with a little extra code), as opposed to requiring a new model, db table, controller, set of views etc for each new widget.

Requirements
============

* ruby 1.9.x
* postgresql (user 'postgres' with no password)

Running the Specs
=================

    $ rake db:setup db:test:prepare
    $ rake

Running the Application
=======================

    $ foreman start
