#!/bin/sh

erl -pa ebin -pa deps/*/ebin -s webdozer_app
