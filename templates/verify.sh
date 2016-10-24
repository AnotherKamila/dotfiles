#!/bin/sh
# verifies whether the expected programs exist

which {{BROWSER}} || echo 'BROWSER missing: {{BROWSER}}'
which {{EDITOR}}  || echo 'EDITOR missing: {{EDITOR}}'
which {{EDITOR}}  || echo 'EDITOR missing: {{EDITOR}}'
