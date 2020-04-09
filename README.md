# dockstore-tool-star

Dockerized STAR and CWL tool definition for Dockstore.

## Contributing

New features should be opened on branches from `develop` and merged there with a code review.

CWL definitions should go in [/cwl](cwl/).

## Tests

Tests can be run with the [cwltest tool](https://github.com/common-workflow-language/cwltest/), using this command:

```shell
cwltest --test tests/test-descriptions.yml --tool cwl-runner
```

## Releasing

TODO: Use semantic versioning, possibly tied to the version of the software the container is wrapping?
