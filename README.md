# raytin1w

[![Crystal CI](https://github.com/satler-git/RayTin1w.cr/actions/workflows/crystal.yml/badge.svg)](https://github.com/satler-git/RayTin1w.cr/actions/workflows/crystal.yml)

This repo for Ray tracing in one weekend.

[Original](https://raytracing.github.io/books/RayTracingInOneWeekend.html)
[Translated](https://inzkyk.booth.pm/items/2186534)

## Next task

1.5 球のレンダリング

## Installation

Clone the repo.

```bash
git clone https://github.com/satler-git/RayTin1w.cr.git
```

And install shards.

```bash
cd RayTin1w.cr
shards install
```

## Usage

Write to ppm.

```bash
crystal run ./src/raytin1w.cr > image.ppm
```

## Developmen

```bash
shards install
ameba
```

## Contributing

1. Fork it (<https://github.com/your-github-user/raytin1w/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [satler-git](https://github.com/your-github-user) - creator and maintainer
