// GENERATED FILE - DO NOT EDIT.
//
// Lossless boundary geometry for local bodies (palikas) of Nepal,
// encoded as compact strings (format version 1 - see
// palika_boundary_codec.dart).
//
// Source: docs/palika-boundaries-highres.geojson (scraped from
// sthaniya.gov.np via Acesmndr/nepal-geojson, MIT license).
// Coordinates quantised to 1e-4 degrees (~11 m) and stored as
// zigzag VLQ deltas: the round trip is bit-exact.
//
// Regenerate with: dart run tool/generate_palika_boundaries_highres.dart

const String kPalikaBoundaryFormatVersion = '1';

const int kPalikaBoundaryFeatureCount = 753;

/// Total boundary vertices across all features (ring closure vertices
/// are re-appended on decode and are not stored).
const int kPalikaBoundaryVertexCount = 17481;

/// Features joined to canonical roster entries.
const int kPalikaBoundaryMatchedCount = 753;

/// Encoded boundaries, keyed by district name then local-body name
/// spelling, e.g. `kPalikaBoundaries['Chitwan']?['Bharatpur']`.
const Map<String, Map<String, String>> kPalikaBoundaries = {
  'Achham': {
    'Bannigadhi Jayagadh': 'BBKwx6Ri00xB/OwP3MHB99BlEtEiI9G6dlB8CoKjGHlDuK',
    'Chaurpati':
        'BBZ+q8R83wxB7N1JnNgCxJ6Y7LjCFoV7PjJ1EuDaiNhR6ExN7HiDxDnHrQnR9UnHtUsWnZ4etMmB1J0FhC+BwXwO2boJ8D+G1K2IuB4X+M',
    'Dhakari':
        'BBRwp3R09yxB1Ym2BzLZhWxTlR1EtNxSqH7L1FpK6Fle6gBxyBuG0BpCsIsKwPyJkE8KtDasd6JuL',
    'Kamal Bazar':
        'BBQk64R8m1xB1TsCtQ8MoD2HzQ7BtLoQrKjH0JvZ/K3ciYlxBqKPsK2d8ayBrF8ToH6I3E4E',
    'Mangalsen':
        'BBU415Ry90xBpgBxH0DzZ7axBrK1dpKQlDrZ5JtLZrdmaxO+JwEyC9LwK7BwFgUwYolBhD0D0I4D6EuOjEoNyEwF',
    'Mellekh':
        'BBOi77R+j2xBhZ3PtS/lBoF/Mble+MrF6FgKsMjXmXwU4EuUmJ6IzZmcK0HqL4J',
    'Panchdebal Binayak':
        'BBSm92Rms2xBuLnQ0Q8BnD1HqWlQmS0BQ0XgLmD4C6GhI4IkS0QqCgPnNsHUgQ9J0G1G+SlW5iB7HpZ',
    'Ramaroshan':
        'BBSk55Ryx3xBpC/OjSzQiI3I3C5G/KlDD7W1IvKkMpG4e0MuQhQwQkgBiZ4PyF+R7SsgBtLgDtH7HvQhD',
    'Sanphebagar':
        'BBd0p8RyozxBtWhY7N2XtExKzGuF3DlL9ckChI+G4DpO5FhNgXhCZhN2EtD8PkJMvV2LsC0FrVmRtFsOoKnGsS2OsB4BqM2IrL6JmBjEubmH7CsDoHnOwUxGtD',
    'Turmakhand':
        'BBe6y2Ril2xB1H3DrL6JtHpBjG2F2BuG/LcpH4N9S0MvF+Nz5B+d9KsOrPf1DtkBqHuJgMnMiOuEuLnPqM5EsH/Q8ZUwMhfrNjZzB3QyK/G8LvZqQ2FiWyTmSwDiFiV',
  },
  'Arghakhanchi': {
    'Bhumikasthan':
        'BBdovjRuw2yBF5JhHiIjOlJ9B2L1KyBvBmKnGgBvIoQzH/D7FyF8E6D9KrBhI9awF3PpFzP2HvCkC5JuV+BqN1K+Jvd+HkNsI4BiRhJ0a4TlKiBe2HhJ2D5JsgB',
    'Chhatradev':
        'BBO28hR+56yBnIrOWjf+YlGoQzYoQ+B6M0PsW5LrXmfvmBoOoBwGrN+KE6MhIgB',
    'Malarani':
        'BBY2wkR6y4yBxVoMxMvPuEjLvK9O6MtWhGzO2I3E6JrgB2IhDPvIiKjBgE0FmLGnJ+QmB8JsGqChBqM1L8CsCgQ7KmCyEuOvJA9F0P',
    'Panini':
        'BBY66hRwr5yBjJ0IwFmG3CoRiK8MtQhGMuRjL1GpVuUrJjIHxKjF+F3O1MuC/ZxLpYkDlG+IxCuR6I6FvL2MnHgFsF0N3F0C3KqUyF',
    'Sandhikharka':
        'BBbyujRyv4yBpQ9BlQ0YnToF0F7e5TzEzC4KzN4FnE3PsIrDzIpMkNhNiLqHqEI7E5DqFtFmI8DwInQoGfwBlK2KxB+B1LkOmJiHhIoGuY5MuWwK+O',
    'Shitaganga':
        'BB1BsrhRyr1yBjC6J1HwCqF0PvF4PqEsSjI8O1FS0IqMrIsDH8JlN4H5FwLtR5I9IyCjDmG2G+L3JkMpLxB5EqIzTxHwH9M3F/YqJ3kBvErD2EvNyIjEpHlCjJrXshB3W0GoCrRvO2BrW/GnT6FrTGj+BwHpDlHlE8RrY2HyE4NogBiFzJ0B0K8GnC0Q6L5CiPoF+LnF+FkIqLnG+M6QgRvDucmE6J',
  },
  'Baglung': {
    'Badigad':
        'BBbqvpRmp7yBxZpOJxH1P0HnEmQtIR9EiIzLkDpHrGvDpW5K7FzBjF+zBx3B9HzKiI1H9MtP4E/DPnT8JoCiR0iBhGoHkJ8R6MwJ5EiJgI+KiCwXmJqL',
    'Baglung':
        'BBWivmR23hzBgM/P1B9I6MyD7I3JnEzeyJ/BaqGwIoCmN9OwHwQ2FqBgG5B9G5F+H7JmRwE2DiMzEqO3H2K7X6E5RokBpQmC',
    'Bareng': 'BBNwrmRsi/yB3K+OnKvDlMoQ1FC4GjcvIrPwDpHqIHtEvfua7U6IiYhFoM',
    'Dhorpatan':
        'BBXi/rRmi4yB16B4F9D4GyDuNqN0JtM+KxF8WmD8NpMyLxT9yB6EhJ5MvJnDxMkPzK6FjXiOO8yBv/B+MtBkF3GwHoQhH0f8IyH9ByX',
    'Galkot':
        'BBZg3nRio+yB5b4b5R1BdjnBiFnMjLpbiVnSxE/tB6K8FwDqWqHsG0LjD+EhIuISoElQ2PzHKyHia+OlDgJ7W4KtSwRwCwLnKyQiGiGlNqK',
    'Jaimini':
        'BBRivmR23hzB1UvIlJoDhQtV1UhPmS9P2LC8FhNyQK+NpQgMkD4HyR5JqF2Eyd8I4J5MxD2B+I',
    'Kathekhola':
        'BBOw5oRwx/yBlMMpHkI2EqI3JE5H7QxFuK/MgF7L7cic9biQhCuQsK8MclDib',
    'Nisikhola':
        'BBWgnsR8rzyBpG2OsE+RpHuPwB2K/RwH/sBi6B1KuHnJtC5FkX7SmJ+DjLvRniBwczWsJ7jB2QhPQ7P4X5G6CnR2TlBuLvRmN3E',
    'Tamankhola':
        'BBR2hqRox6yBmDxgBuM9KpNzJxDtN+D3Gy5BpG6EkG8OxBwBmT+JoTxMyhBzOkOhJkBvIhQxHqB7I6N',
    'Tarakhola':
        'BBQkkpRsx+yBhgB5LhNwCxCxMmNjKhGnGoKxQvCvLuSvR8W3K8N7SqJ6UDwRxJ8IsB+U/RiU',
  },
  'Baitadi': {
    'Dasharathchand':
        'BBdsuiSokjxBjJ3LnE2GxM8B0CuItGoR/N2DjQuQ7F9G9QgGgG1OpFzHvGsC5EtRyBtIoDuF4KF9E7OwLtJflRmHjC8G/PyFiG4FtKgHcqCqNyEPzB4JghBsY',
    'Dilasaini':
        'BBY4qjS8spxB2IzOJjF1FiE5BpEyIlMyBlK7G5B4EzLpMoF/HxLhThD0G/DlE3WiOncN7oBse2qB+BulBlFwQ8OwVnE4IuFyc7D2QrL+I',
    'Dogada Kedar':
        'BBO0uiSoxmxB7R7B9G3QpRKwDnX7H5PoTrNiBtpByM7BsD3GuP4QVqcuKuKZ4kB',
    'Melauli':
        'BBe08/Rw4jxB9FmJ5DpD7LmGxFnL7KzE/EsGjDhIrD4D1M/S+DnG7L3J9KV8CrIlIrSoEpE2MuG6GxCyN4M0GtNoD+F2VIpFnP4EvG0FwCwQ26BnJoB3E9FxBuI6EuR',
    'Pancheshwor':
        'BBcq9/R+0ixBlN5qBzFvClGmLhP3F7G9JzIiI/B/MnH7CkHnMxP/SyOL0LzUmVsBwCiTwDlDmCsE5E2CsB4NiP5JsI2HxDgJ8IGgHuRqIkE7GgQtH0CoB2Q',
    'Patan':
        'BBiBk//R6vnxBzFqG/U5B5R6ckD3ZlDrF3KkG3LvR2ItVBvV2JtDkE/OrM3ClE9JqEtSnIlOwG3NgN8MgFrG8K0E2EkL4MhG6DqDsHlJ0DkH/FqO4Q9F2E6E7K2G0Ckd6FqH9FOtBsPjMuO',
    'Puchaundi':
        'BBd4qjS8spxBhJT5DiS9EnGnTyD1alGhFrDcrOjOABpRqO1Y/IrjB8HpDpBhUqRJ+G4Q8R+BoEsWpGqE4S4CgIyLqMnF3E0L8G6BxBmKxImM6BqE2FhEKkF',
    'Shivanath':
        'BBU6n9Ro2hxBxHqC5G7FqEjG9PlR6JlSmZ1P0R0R9FiQoHgDwB6MkJ7H8G+J8HNoP2MpBiE1VHnD9FzGuNxN3M',
    'Sigas':
        'BBY24gS2jpxBzEoUpK6EyF+RjdyYhD+LtN6EX2PjSzUhDvO9GiFrM9F6CzJnK7Me9RmM3O6IkD2Fpc8MnHgL3XgV6B2FlGuBuUoYqN',
    'Surnaya':
        'BBVwkhS++lxBqBiU7HqD8IkkBhIyS5JwGpUjPN/gBhF3EsD/Q+IlGqBhP+FN5FpHzCjd8StH+J7NyNtD4C4PnToN8H+P',
  },
  'Bajhang': {
    'Bitthadchir':
        'BBTgihS+orxB9IkMjNjB5KwM5QPrP4HY1PuN5EiD9LkdxYxF9RoK5EmErT0HnC6IwF1CoK2GqDuDya5N+I',
    'Bungal':
        'BBnBgmmS6hwxB/ZvIjnBHtI1FkFzLvMhO7dhKtGtRxX/K1FnR+C5H3I/GLnLvHxIc7NsG0FoGvH1S9L0B3KyNpHlDlc2fgH0MpE+EoG6DhSiJUmC6J4I6Bd0GwGyCTyb8LmPmSgvBvIiWiMiIwEoU3DgHuM8RgtBwK',
    'Chhabis Pathibhara':
        'BBT+uhS4nwxBvKMpDgGvH7E7E+F3C1ErE2I3FJnJ3wB6NAyevd0SjM2KkBmMoJqD0OtI2O9NWPmTvLuG',
    'Durgathali':
        'BBN0giSk5txB9gBgUnTgV9OyBhEzFLrRoJhMnF3H6FtFkOmG+CnI0c3HwD7F',
    'Jayaprithvi':
        'BBd03iS8kyxBjG1JlG6NlL9CtMqK7MhPlEoN3N8KlcgqBOvf1H/PkG/KlCrKgGhU2N/OlBzI4FKsDpI4DqE8E9F2G+EoFxGqPyCuEsJ3D4CqM0GfgGgToE4F2L',
    'Kanda':
        'BB1BipjSil3xByKhmBvB/kBgQ3V+P6BwG1FzBzd9GxGqQ5XshB7PmPrgB7KpSgRrMjF3MoIrO+ZGuPlI0N9QgTkN6NjEwVuOwYkhBnVwUtF+PN+VwHyG3JiOsCoR6HkFkF9JuI0V1Vm1BjCyP4JiMzN+iBrRkI3N7K7SmG5M1D1G2I8C6V5GmRhU+T9ZjExJpH9O2InKjFvE7HgExQ1GjDjUiKjGjGrNa',
    'Kedarsyun':
        'BBZi0hS4jtxBvD8Fzc4H9CoI7H5GrK+CyD8KnI8I/LxSkBvhBrFpL3GdoNnJ6QQ6KvMkNkB0G3LoN4BoGkG7G+FzF1Fb8NwHyIMoL4IgH',
    'Khaptad Chhanna':
        'BBY61/R62zxBhJwKzF/C9KvZ7MtG1BxNiLpU1BjKpH9DkIpL8C5XqHiIwF5IgHHFvS0SiUWyI8FhDyBkK1NgP/FiUmCsKjGkK2H8Q',
    'Masta': 'BBIkhhSgm1xBroBtiB6vBliCuCoJ0YyP2EqNvI8BlNkrB',
    'Surma':
        'BBZ03iS8kyxBgC/R3F1L/SnEsCpEvNhIiBhK7H3EwGnNwLtGQlT+NVoIpQud6JwMiOjF0LuI2FunBK2ZuIqJ6M9e+S/NiC/Y6dlMqCpF6H',
    'Talkot':
        'BBfipjSil3xBxJ7Y7ctFhN3MxLgB7I/UwRvRmNjrBwI7B1EpN9P5JuMpKmL+CwG9N4BgKqkBwGqF5HmMpCgZ5dgOhC+e9SzN8lBrhB8PpQ6X+GyG0B0dvG2F9P5BzP6UnD4VsEmQ',
    'Thalara':
        'BBQwngSsxwxB7FiDJ9H9U3b1HOvFnY7LvIjMxhB1B1T+a7QsJFsFuLjBshBgMySTyU8IiN',
  },
  'Bajura': {
    'Badimalika':
        'BBTyz+R4u5xBxJrJ1cpI9HxwB4CtXsnB3kBkJsKtLiKkTpJ6HiC8H0W4K7C4VsL1Dob+N8a3LHrO6Z/R9D1N6K',
    'Budhiganga':
        'BBO6y+Rww1xB7OqGrd1rBxX1RrF7QkQrJ4KmLa7GoRwI9H8KoCmO6TkH7D4IyN4H',
    'Budhinanda':
        'BBU21/Ro/7xB0E5ErJtI/D/blVvW/GQ6CnRsNuE2N5KgS+DsO5Z6OYwP4TgW1WmnB+FlT+Y/LgDpc+2BxckLpGqK',
    'Gaumul':
        'BBYwqjSo24xBlnB9F/V2WjV9UrLla2Dnb3VrL3K8CvF/PF/oBtHzGmP5bqEjBqC8LyHoCuIgP0b+T2FsSyLfiN4Mqd+F+OgrB6OmP9C4H',
    'Himali':
        'BBoB8ogSy98xBtK9X3IrGuWVqGpKycjLqc92BgM/CgHjP2czRqFlL6IwF0YzI2CkaoKkF+O1IyJqH+ZkEyQxOqKxWmGiHyLAyQyqD9Y8RiBgoB7FgMj7B3LxFlE3DpVpkB7H7iB1SzWuBnNoK9ImNPiX1F+JxMwF3cvDnI3JjFiC',
    'Jagannath':
        'BBT21/Ro/7xB5HhFtQmCxDiFliBuD5U0O9E5D7K9rB2CvNuV9CwJrQ/LnjB2VegUsJzBgWgHPmVwWgEgcsJuI',
    'Khaptad Chhededaha':
        'BBV6r/R8/1xBvLtEjTqJuLhKnK/dxN3HyCnKvSzFnClO+H7KnRvIZ8G1EnG2JpJyNxiBoX2WgBuP8MuGoQwcxJmTuH0G',
    'Swami Kartik': 'BBK8i9Rwz8xB6UzOm2B1KyQuLuK+X9BsNxWwO9kB3FpLrF/BhS',
    'Tribeni':
        'BBRov9Rm+4xBnPvHhOnOJ9J7VhP5E7J2J1PxGrQkQ1VpL3JJzH+SpPkF3Q4hB2hB2NkY9d8ctBiwB',
  },
  'Banke': {
    'Baijanath':
        'BBgBghpRst8xBnY/OnYpGhF9QnLvG/B3TvgB3F3G3PuE3CsJwHoOhNhJ9RhGLgB/JvG9G4E5FmTwFoHwUyGMBqGkO4K1C0KgI6D+K0VsIhE6I+H/DuF8VmJrFiByIiIsGjL/B6R',
    'Duduwa':
        'BBagpiRm38xBzI6H3I5Eid1kBuI3sBsRiNtUsO0GgJoGiC0G1GyH8FwGzGkJuD2FnFuE8JmD5EsD0EyJ5C2MuRxPyEtEuJ/UnLvJkN5RHjNhLA+S',
    'Janaki':
        'BBT8tlRol7xBrJtD4BhPzEhGhK6HvItOpKhDqElRzd7BiS5e+FiBoCgN+F7FrCoM+MrIkB0M4T2MsNknBnFvB',
    'Khajura':
        'BBb29lRkn6xB8BiL7MlDzHvYrV1OQzKlNkI0C/L9F8FnC/M9FhByJvUsET+EgN2EhJqWnHyLEkHwO6E/BvEwGwG+GfgKiGMiJ+RnOiNrJvHtE4C',
    'Kohalpur':
        'BBVmooRkn+xB3PxUzU9GjTvbxoB5UiBtJuG3DZhO0JtC9CxL4KZrEjKqiB4FgC4ToLwGiF+QoYqGmY6O3M6f/MiE2F0I',
    'Narainapur':
        'BBQgshRk6gyB3d5W7JS1DzQ0b3pBqDrRgY9doJ2EqGnIiFqIhCgWqQgP7JsSA+NpYmfV0R',
    'Nepalgunj':
        'BBZonlRu37xB9J1LzEmEzG7ElD6EtE7J1FoFjJtDvG0GxH7FzG2GnGhCzG/IuUrO1RlO0O1X0d8BpEmRqKiDwIuOiK5H0EiG3BiPiHbyDkH',
    'Rapti Sonari':
        'BBnBmooRkn+xB3MqUnKLgD4NrKmY7KmDlUokB/X0TzYiDzQi2BvZi0BpxBc4F1kBtI1ImCvf3SlBsEvvB5DtS0LhFuG5dkU/VxB9K8JrSjQzO8BrWpFnCiCvFsRxBzB7RgHLoI4KmRCsO5NkQ+LtBhF4UpJ2lBmSkTwb0U+G',
  },
  'Bara': {
    'Aadarsha Kotwal':
        'BBRmkvQgu/zBpa4EjEvHjFwJxHvF7F4DuB/M6MP3D3S9OvSyKlD8D8C/D+E0QkFuG2SqO9IBiT',
    'Baragadhi':
        'BBPu3vQk4/zB5H2B/QxSHzTrO+IxBxRqJtFqYQ0IvG8DmXvOqElBuH6L3DB2N6E0B',
    'Bishrampur': 'BBIu3vQs16zB5L3HxL6ClC0SpJduDvgB8InQ+Wyc',
    'Devtal': 'BBOmgvQiu8zBjEzCrDkP9HtDpBnL9H4P/KrCyD9T5LfuCxTkQ2IjBiGkH6EiT8C',
    'Jitpur Simara':
        'BBgBms2Qwg9zBjlBkG9NlNhM/C/d+Wjb0EtC4H5fzBrL8H5MzMIxG2IpBqJoH3G5LiGNkIpN3c1P9D5PmI9EwBhO5HhKiL/G6FiKsLa2JsImXtG8iC0TqTjLkL2GyTpBmJ+R/HoF',
    'Kalaiya':
        'BBc44wQux9zB1V3DDnHvN1HzD1KhCyGjI9B7G5Eb1MhavHjC1IqNpHuD/NuJsBhD4J4J2JmJtFLvF2JwDmF5M6GqFIsMkTyVsZuLsCyJlNuI4G6LtJnH',
    'Karaiyamai':
        'BBTy8vQ42+zBzF3YzEqHvOgEhM3DpB9GsPrBsEpHqOwE8G5W2DiK6KpBuOgIwB2I7EnBpCyP8F2E3EiJ5K/G',
    'Kolhabi':
        'BBVo0xQ+lg0BxInGxX0C/J7KOsIhHyCfzOrIuMjDxHuGxK5EzBC1N3LoEkB9HgbnJ+OiHwE/mB6JkOsL7H6f0BmKo2B',
    'Mahagadhimai':
        'BBVg3uQyg+zB7WrIyE9O4PwD/M5DsF7H5G5EuJrQqBoLgIsD+DvP+K2NkI+ByClGoHsOqErDgBiLrG+P/OrE1DmHxJ5C',
    'Nijagadh':
        'BBVo0xQ+lg0BunB9VpKpxByC1MkbzEue/WyZoQ+lBzFNua3R8EjJ2NzPgGlGwLhNgHzK6WoCyflMoJ1BoIrDtFjnBjKlPpJ',
    'Pacharauta':
        'BBR43uQyl+zB3MsKlB9FjRzFwEtE7D7C3OT5CmJjQ/KtIkBkB/oB4MyE2GsTY3FqOiF4EoOgOF',
    'Parawanipur': 'BBIq6wQss7zBjW5G6GlS3KxDH9JsY0L/D2L6HwJ',
    'Pheta': 'BBK+9vQgl7zB3FDrBsKtJ1DMwFlKkF3IrJkFnc2L9CiM+H',
    'Prasauni': 'BBKq2wQ+k8zB/S/QHrMlMzOiB5LiToG5GmSqW+GGoIlI+E',
    'Simroungadh': 'BBKmztQgz/zBvLVhCpHpMoIS12B8NiJ2F9HoQiV4DgT5MI',
    'Subarna': 'BBMkguQm49zBxICrE/NvN/D2I5lBYiG2Q7BrDyUsQ8H9EoIwMK/PD',
  },
  'Bardiya': {
    'Badhaiyatal':
        'BBf2nkRm+3xB+H5QqWiDiO7UiMhC+I7WyWgBkF5P4IyBJmKpO0JiCuYoKkH1HyBzDkJ0FmHvBoPmJmLnC0G7EhDwByEtJkEnI7U1HQpCjHxNiDlIpP1QyBzG0GhBjFnMoN',
    'Bansgadhi':
        'BBd4lnRkk2xBmJ0HsPyBX0H+GfuJ4OiW4N5L6S0DkG1G4O8EmJnK0JXmLoK6O1FsV9IzHtIyD5KtVlIhEiDlK7Q3O4L3O/KpRqDjJzFhD0DnN2HxBnKjHhCtY',
    'Barbardiya':
        'BBbwkpRuz3xBxW3QtJ3O9GgBYzHrPxBlJzHsHxE8D7VuHiEyC1H4K/CnB5OgM/csF0HiW0FsZxEH0H2HP2S4Q8F6QHkH1IhD9R2JnJsWrPmK0DsT',
    'Geruwa': 'BBNmvuRq9yxBhWP9vB9X1HyEhO1LhWkGxC3NqVnLoMmJ+HxCsDjHoLxDXzJ',
    'Gulariya':
        'BBW6unRqwzxB4SkM4N1F5KqcuB4O5KgD1C8HtHjEnD0L7IzBjFmQrWboBzWnH7EjGkHlIrExFphBqHG8BgGkLpQ4BkM4RN',
    'Madhuwan':
        'BBUkgqRu8zxB1SuH3U1EnI3I7OgG3SjM6hB5dqWkBgVlNyD1MkQqN2VhDHkN0HgLlGwGzItF7CoF5HnB3GwThGrB',
    'Rajapur':
        'BBPu9qR6iyxB5NoEjQpNkN5mCsO9MkfkUqCgL6WsaLsGjLwDrDqH7I+BnL/ItNoE7HkH',
    'Thakurbaba':
        'BBXyirR080xBzLpQ5R9F/E9JoGjJiGsB4GvT6HoB8CnF0IuFmGvG1GxQqZoQhK8C2DiFqHb6X2SoKyZ7XpBlDkHhJ7LnIsOrIrE',
  },
  'Bhaktapur': {
    'Bhaktapur': 'BBEuq8Qu5k0B8FtayD8VsHoI',
    'Changunarayan': 'BBLsm8Qq4l0BiE7e6Q2DrHnIjBtS8P1FoPmZvH+X8H0cpVK/CpL',
    'Madhyapur Thimi': 'BBE2h9Q08j0B9O6FnGthBoJqD',
    'Suryabinayak': 'BBHuq8Qu5k0BnHkgBnR/SoH5F3K7VgatkBoH4C',
  },
  'Bhojpur': {
    'Aamchowk':
        'BBU85vQsrk1Bjc4XrbDrH6MpI/OzB5fhN1Y+FxN0G3BlBnQ+gBsNuKLkHxJ6NoGiI/NyR+FgGwG9FmDlB2PpUqZ',
    'Arun':
        'BBPgq0Qunn1BlF3B9R4VjQ+FzJuPhKsCzK3CtKxQjFKvHvR+Y7fodxDkFpdklBqPyD4Q',
    'Bhojpur':
        'BBT6t0Qo9l1BlnBvO4BzG9Q7HxLmHzPkBrH7F/NyDgQvPnBzNiXlWisB7VsPsI2BiLuI8CvF4J2NkL5IiGjI0W',
    'Hatuwagadhi':
        'BBPqmwQy5m1Bhb0I9UhX/MWlFjI9EoG7IrBkHlHtCxR6GnM+bNkc3XkJqLoOsC0I+f',
    'Pauwa Dunma':
        'BBNstxQ2un1B5TlVpTB4DnNoNvLiD7PyajOsH8F0PjB8H1H0UsI3EkjBpdyD',
    'Ramprasad Rai':
        'BBOsnyQq4j1B3R6QoB0NlGmIzX8V/EhYhRhGtPxU2KlW6I1FuCtSmXtOoInS8NiR',
    'Salpa Silichho':
        'BBY6t3Q+2l1ByDvQ7UvuB1ShDnE4F7YrN1CpOmT/X4JnBsDtJqI7E6IqEqO1MmQ3CiG+QiKwEvO0rBsHgUpEoJ8LuJ5C+NkFgJhK4TtMhK',
    'Shadananda':
        'BBS6t3Q+2l1B/LiCxakmB1WpG7IiMxVoFpC7H5FmFsHtZ7HhpBkIzWyGnJwGesPtXwXiMoE3F2SiD8UwuB',
    'Tyamke Maiyum':
        'BBXm40Qilk1BtL9HwF3JtI7C1BhLrPrIpxBsbzQn0B/O7Q0E5IuGnF4IgOoRwDuIlGkVwKiMb0Q3UmEgDsHiLpBkTkVwNuI6bnQiW',
  },
  'Chitwan': {
    'Bharatpur':
        'BBtBis/QoqyzB7GZnDmMzKwF5KlFxM4GlRlGlHnT1N/F7iB0IzB3G5ZoEjGhFkCnHjHkDgBxM9J9JuHlGLzRlH/EsHzTjLnV4I9M7DnGsD7cvFtJkMvLzKjU2DvM0OwLiSijBgX4ZyH+XsTmJkEkNvN8R8O+f0W/EeuJsKuIjDsNiMjHoIpSsQYqGqI',
    'Ichchhakamana':
        'BBe2z9Q051zBwEjXwWzSvH9P2DrGzRzEtH7NmFepCrQoLiFgN3GsJwFwTnSZ4NmKqDiCyUgOuCwNmT/E0LiFwKhM0G5GyPjPqD/Jzd3FiR1K5E3CiX9H7D3EiI1MhH',
    'Kalika':
        'BBZ2z9Q051zB7G0L9W/G3CxQrK7G0PzRnCtR9FvEsEhPtH7QtIjEmKnK9FxN+D9D2MnC4N4F0E6Q+IuEkC6PnFnBwHmO0R0E1DsGsHoQrWqS',
    'Khairhani':
        'BBTy28Q2o0zBpFuDnd1I5S6KzEqLzLuDLgJjEvsBlLjKYragG2FoKzE+JgU6HvKU+K2JzI2LsMoY+ChCkO',
    'Madi':
        'BBUoh3Q0izzBrFqCzC7VjGlK/HlBuClG1EnDyJvSpB7e+N/4BtDtF2G1JwMkBwV9OkNoJma5FnnBquCpHsenMsNc6N',
    'Rapti':
        'BBYus6Q4x2zBqKrjB5FrR0LtD0EpL6S5Kod2IqFtDyBsNrP4QsK8GsCsQ6aiJwGqmBxQsY3KvGjD6D7StP9F1OmFoBa3G/G1IjFtClViN',
    'Ratnanagar':
        'BBWgi6Qg1yzBwD7J0Q1GhH9M2E+D6DrEjCoHkGiF6ZnE2B4GqR/EwGiQlKoKuIkE2H6T5a7E1LrM1J0IT9KtIoKpJ3TnK0E',
  },
  'Dadeldhura': {
    'Aalital':
        'BBcog7R07jxBjGggB2F0TlF+DzBwT/X0MjOlRrJTlCpP/PBlI/YhKiDtM6S/YhR7JY9MvVmCpS4GiDgBwIuYjDgJxajC5KkTwHqHzFsgBgDwQoR6Q7IqQqH',
    'Ajayameru':
        'BBW2g+Ry1mxBle1SxTpa6FhGhGjJsFtE3FlN6NlJrE7N4P7kBsEwHyKO8L4J9DoGmGuKvG4NoImOpEuSmE+JuM0ClEkP1JuD',
    'Amargadhi':
        'BBU2/9Ry3mxB/T2ChT1G5NyfxF3KxI8CvI7MpIzBP1HlThNuC5UmF9D1FzTkG/foPuKrB4MkNhDgKmcgMxFoIyT',
    'Bhageshwor':
        'BBa+r9R4tixBpFfjNuc0CsVvMuEuEkStFiEkGqJvPuJ1J5btN2CsB3MzPrL2Kp3BrJtCrE2E1JnMlHvlBkIzLqJxCwzBwQV2K4NkMvE2F6G8FwHvC',
    'Ganyapdhura':
        'BBNyt8RompxB/JrMpPkP/NhLzIlUvYxBxHr0B2dvLqhB8iB2I5CgLgU7DsO+H8R',
    'Nawadurga':
        'BBVyt8RompxB4GzJ7HxR6D1OtEpK2MnemTuGgU1CxDiPuKuQmMhFgE2H5P+1B5IjDjM0OzF7J8DtEtKtDrL6BnIiKzItC',
    'Parashuram':
        'BBmB2g7R8xjxBvS1K7Q6ItJxNzP5FhYZ/G0FjTvHkC6K/Iya/Z4BsB9H4F4BO3F2L5F7GzY+MvU1B7TgG1E6Cxd9H1RuE9K5ErQma5aqfd3Lye0P2Y+NhJwNHuJ1KyL2ElQmZkN6DnIkMqHglB2JoMsE1EsJuC',
  },
  'Dailekh': {
    'Aathbis':
        'BBUyu3Rqh5xB9DzN9TlL1I9ZpQ0CjJyVjP9IzCwFzM7X2RzUgMb1BtGkG1FuHqBsL5JyEyF2KXujBogBmI6Zgc6qB',
    'Bhagawatimai':
        'BBRoi0R+r/xBxY9ElmBmUpL5R9JzDtE5cxM5K4FlN0M1DiI7RqMtC+FrNoMvDjCociIuHoC0SuiB6c',
    'Bhairabi':
        'BBX6g3R647xB5SxPvHvRtQP5MgJ1XpI/hB8VzG5EuLha8LvI8KuDnD9N6F5PqIyD9F+CsH8EqtB4Q+G3GuR4DwFrEyHoKjE6MkGiX',
    'Chamunda Bindrasaini':
        'BBPit2Rki6xBpIkG10BzVgG5CrI1D0ExFpE1SnTnKwNzKgI/P4FnD+U2jBkTmL2BiQqNkN',
    'Dullu':
        'BBR2t0Rks5xB5F6PoD+N7KtD7LwItLka1J5BnFmI9KXnUpKzCrTqPrbzE/J0LxOqsBrVmTmMqE2S',
    'Dungeshwor':
        'BBRijxR6w9xBjJtKiCjHlGdzFnZ4OnVtC5XwNzCgN4FoKiQiRgDvBiUsF6FnMwD9FsNpMuChI8R',
    'Gurans':
        'BBYg3xRk76xB/M3FvN0CuC6X3O6UuD2UsI+FhCkHkJuK5FqNtYxCrRxR/JMwFjayVlpB1BvW6J9FtBtI6KtJqDnQ8W9RqEoUsOa2EuJ',
    'Mahabu':
        'BBPu02Ruy8xBnEzHpXvH9IsNxKvI5L0ChItNpU7BjM9OwgBzU2XqI6M/IgTgB+EgR6SyP',
    'Narayan':
        'BBT+jzRii+xBzF5DnC1S5HxGiEpYvHtKwBnU2HuBoFlIgSsF+L8OmQfmMqQ2QI8F0R/ImHlStJ/I+KtXzI',
    'Naumule':
        'BBVoi0R+r/xBjBpQpd7Z2Q/kBuX0IyL7K0PsJgJhH9B/LwIxEmC9ImYmI+G6exUyW5H2SR6OiI2JuBkOvF0FncoE5TrU',
    'Thantikandh':
        'BBP0i3R8g6xBvFsEhQjDApKpNjNtBzPrTzL/HrL+BjG2P6IkJxVqQzCoJ2aoU6LCqc',
  },
  'Dang': {
    'Babai':
        'BBSo5nRq8kyB7hBnM1VO1HsHrErQ/UhXtUlJsO1oBiUd6L7GoT0G0D8GwI5D2YgSrCuK4NkUzEgU/I8G',
    'Bangalachuli':
        'BBZ46gR+1wyBiHnFuIxiBxGrSsJ36BgU4PyPjI8PmO6ClLgOxHiCndoM7O2FwesR0S/O4PjOs6BhLrN9Ib1Puc1JmDsBkK5ImC7LlJlLkP3C/D',
    'Dangisharan':
        'BBR4qlRk3lyB9ClDI4cxK1CrW3d7M+TlFpL7GmIzJpH2U1buU70B8ICmRyQxI4N2CyXkLPgSwL',
    'Gadhawa':
        'BBbk0/QqptyBlIsFrBwSmDikCjS2YgH6E5PwG9GxNiFfbld9KzHlB3QhZ0FtB9U8EzErMrc3P7/CmZ4CoCyJqNjBuHkJ+GnFyQkE+blJyEwNnGmR4DmN',
    'Ghorahi':
        'BBlBq2kRmntyB/Q3Q1FvenM8OhCod/NyH7CoLhTxPlMuJhPzJzG3X3O6FMlIiJ1GxDtNmGZoCxLpK/K2NrX2EhhBkTxmByRkOqElKyLsJsDpNwSgCsNoiBkY3CmHsFwBuRyQuEhGqe1IqDkMkMnL+V4CqL/MqG',
    'Lamahi':
        'BBhBykjR45lyBjL8kBhQsVnWi1BxE6gB5N0XoKyLlCgLlGakDsOnK2JwBuE2HrG4K6EhG6mBrftC9LjI3G8ClDp1BoGlRlF9LyQnNBzXoH7IFnLoK/D6DvnB4K3L+HpYmHjDlJvJkpBpkB+YyD',
    'Rajpur':
        'BBhB61/Q++qyB9bmJxQjE9GoFtHjJpNkBnCxJlZ3CiBtKiPtd8YxV4SvnBisB57BuO7hBlFvCuE1Q4jB/iB2LlCqH2DtCkfuI2I3F2kBsOKxhB8gBmJwJlHkD9HqY3K4L5DwnBnKgEGoLnH8IC0X',
    'Rapti':
        'BBR46gR+1wyB/KoTlGuCjCzKpE6J/NtgB1HxE7CzkCsBvSmIrFmD0J4G7C+LkImewDtEqiBwGkQtIyiB',
    'Shantinagar':
        'BBQ2wnRwqmyBnO+Fh3B7U4G1L8M3F/RvLnLMxE3JqI9ZiQiMuEwQ2HrH2VN8hBoMrF8RmE+L',
    'Tulsipur':
        'BBhBq8lRo/pyBxQtEvBtRlHrFjY4CtD/QrMtS9C4DjNxErDqNxLrJpEmKrNrH3EnK4TrgBkL7kB0JqH8GlImFqL8M9TsW4dsJ0CgB3ciFgJ6dyN2XgG+O/EqEwiBhOqHE4PhVuSLiQxMqC',
  },
  'Darchula': {
    'Apihimal':
        'BBjB+xpSsquxB5NkEnThNrN8QtPmIzZN9JmTtqBrJhJhP4D/GvEnUqNlL/BjW8Xx2BFpEnL0ElH/M8EzKoFmD9F3QoMlgBwSnFsGkNqGAsTxRsEwDlC0MsetG6B2SzP6V6XuNmG+WkZwD1RmwBuNiQ',
    'Byas':
        'BBhC8/qS86vxBgUmL0IvGI1KgekBse9e0GyHiMrMiO6DqNxawBnX/EpK+E/FmF8CoNtR2P7+B4S3J+c/gBwKpR7BrLqRvS8L5VjChGyH1EtDtYzTpY5G3BnG0I+QqVgCgYhiBwQlI+K3UyGtY04B1QoDnmC0hCpVqHzKvVhKlChG7VzUtQvErL5avI/D1R5Z7Z7BrS6F1LxHxVvSlNhO3BwV2dzoBosBfsOoI+InC0MsetG6B0SzP8V6XuNmG+WkZwD1RmwBwNiQxDkdwVuO',
    'Duhun': 'BBIkwnSq4nxBzJzVlHAoEprBmJrLsTmJwVudjI6N',
    'Lekam':
        'BBRiljS4zkxBzRlNMrd1MzZoKFwF8HwN/C4H7PyJ3EwDmRpE+MiRiEvC0I+E0HtF2NtNsGhF8R',
    'Mahakali':
        'BBWq/mS2inxB5bhJhOhUS7NpT5KkFxL3ErIyIlDjEvKgH7HE9U8G3MjF/N3FiBT/MyT0GmHsRxG0kB6NiFuUggBgJkEzK4hB',
    'Malikarjun':
        'BBPijlS+4kxBpTzf7GoI9C3fhRnEkCrdykBxMyGuCwI2e4FhBkFgO7G4MD+U/G8HkEwK',
    'Marma':
        'BBUo8kSy5txBhMhIwIhWlS/uB7LlPhCnS+OrjBlF9sBiL3K8aimBgV0GnMmgB+F4QnFlD7E0KmHgNoLzEGqE7Xy2BgCkW',
    'Naugad':
        'BBT6vnS+yoxB3Y2RpHnNjXmFrQxG5D1KhKvD9I5TuJjFlL5lBuLxYsH/CwTmKR8NiOiU4WgLoM9BuJ4R/D0P',
    'Shailyashikhar':
        'BBUmjlS6tlxB3JyE3J2WmL+lBnFmFvIlE9K0K1HjF3DpO8FnL9BtlBtKjJlLzZsLoEiF7RuNrGwF1QOwS8GnIgYsnB',
  },
  'Dhading': {
    'Benighat Rorang':
        'BBe2n/Qg93zBsCsQjG+H4GqChC0F9JgC/X3I1CsHjYgNCoJpO2T7PtMiO/gBhNzS4MtI4KwGyQrY/IvoB4FjL2E9C2MiH4EhI+H8D4ChX2K6E4FhRgK0dxS2oBkO8T9FyG',
    'Dhunibenshi':
        'BBO688Qiu+zBybkFwC4H2NnE4H89BPqO/JgL5I/BrFthBzFgFpHlP5VpFrHvY4InS',
    'Gajuri':
        'BBP2k9Qm+7zBvO7X0U75BmZxO2CrHgY4IsDlDjC2W+EwMvHkWiMmR/KVyCjDvMxGpLiC',
    'Galchhi':
        'BBVm5/Q4o8zBxFyK1OxG8EmSvM+GhL0bhIrJ0K1UjEnPhJvDInKtjBtCI5FwkB9fqLhCwMyGxCkDwKoBfxOyU3OgD8S',
    'Ganga Jamuna':
        'BBS8klRqq8zBlQKpNvQ9XzKpInTwJ/WsI/E2J+EkF1ftDvPqgBqN2C2P7M4OkCiQqO2GKyRgY6CnVwb',
    'Jwalamukhi': 'BBI6uiR8w4zBjJgS/VgH5V3DtVp4BwdxPkhB+H6Lgc',
    'Khaniyabas': 'BBMm/kRm0+zB9ShHrGnhB7VtSrElX6D3S+X0K2MmQ0RE6L2LZ6anP+V',
    'Netrawati': 'BBN+tjRq+7zB5R0IzF4RlM5BrPlNkGvU7E/NwK1S6QhKsC8XkGnP+FoCwJ8Z',
    'Nilkhantha':
        'BBU23iR0q6zB/Q8JvK2S6EyLnGkO0C6N/oB1Q5QE9E8KtFHqGhsB5DpRiO9Q7C/JyKuFuI3P6V4DgW/GwMxSiHoL',
    'Rubi Valley':
        'BBZm/kRm0+zBoCpNoP9VnDxKsGrJ9O1SkJ9BoVvb2P6H+Q3FiR6QlCuEyH8BoFgQ8S2G6GpD+NsIgNwV3IyxBhzB4a5QtJhMyK3R/CxUjb7PjE',
    'Siddhalek':
        'BBQ85gRkm5zB/H0P7LzE4DqJvEgIld+VZ2I/EpB7ErK4HvahFnZ2KpH5G/EkG9HY3Tsb3E',
    'Thakre':
        'BBQoy+Qwh+zBlDsLxOoOpJxBmBrGrb7E+KtPxNlf4JxC/E7EqFnUujBuCHoKiJwDkEoPzK2U',
    'Tripurasundari':
        'BBNymjR026zBxGxDjHkPMzmCpL/KerOjHjN4SuMqDyN+VjBsRiKtCmtBjO5C',
  },
  'Dhankuta': {
    'Chaubise':
        'BBR+5sQ8tr1BqKnIuiBkB8I1EQqQ0K2MzD6J+KsRvR4VrOtDrU6G1K/FAuX1O4MrCnsB+JpExJ9e',
    'Chhathar Jorpati':
        'BBNg5uQo5r1B9I7GH5PlH9M4P9HsVsGgT9BuHtNqBxTwetIlM4egOgV96Bqe',
    'Dhankuta': 'BBJ0ouQ01q1BnQt/BmhBvFmemXwG/HyLyVhJ2c/S+BrVrG',
    'Mahalaxmi':
        'BBP6pxQu8q1B/N/UqJtQ4IlrBoNzKwK+PwSGwEjFsFwO/EyPwDyhBpFoGzHlBpTsUjIxH',
    'Pakhribas':
        'BBOgoxQ2op1B5egJ9K5RjGkI3VxSjCpRwSrR9C3P8ehMuRsH6N2Q+GmRoGgBnN0K',
    'Sahidbhumi':
        'BBQsivQu1o1BzK1ErfuF2Dhc5I5E/CrLsLxbhJ9BsC1DoKmB+EnGmFkIgNVwZ8X+C4PvSsR',
    'Sangurigadhi':
        'BBX+5sQ8tr1B3C7RzMrPqFnb+M5QzFpZiInOvJ3JoB/K2HnWmYpB4E6BrLubgDsL6I6E3E+eiG0E3EiI4G4DkDkaiNue7I2EtiBjB',
  },
  'Dhanusha': {
    'Aurahi': 'BBIq7pQ62w0BzK7B1C5KzJS0KlgBuG0H6OhFc2U',
    'Bateshwor': 'BBKo2sQ6zu0BzK9B5JxK4CzFgWIkClNkagGqLkMvJuC5C0H',
    'Bideha':
        'BBR2jpQmzx0B9O6C1IlJkJpMyF/Y/HrL4B5N2GsDkC+MsLgGpEiG0JR2C6KuJkBpDgWlH1C5BoN',
    'Chhireshwornath':
        'BBOwssQ02v0BpmBlQoBpMkH4JyJX1C5IgElI+H0CIpNoWgOqJwMTkM2QwElImJ',
    'Dhanauji': 'BBK8upQyqv0BpF4a5MtH/LxfsJ2C8CxP8ENiF+F1E6KoM8D',
    'Dhanushadham':
        'BBUwosQkwx0B9WlBuIjFiB/JrGrD6GjB3MjQkN1CxGhH2N6FiGnRuoBkIsMzD8KoLb0HmMsHzHsKlMjI5jBqInLoQ',
    'Ganeshman Charnath':
        'BBbulsQm0y0B8BzO7FnMiHlJ2IRoJ9O+YrJ6OGoK2H0HrKlMrH6C/C6M1FgP6EoR1DnD2yBtU4yBnfsqB9LgC/FvVxJ/BuXhnBwFF3ElJzH7G1Ob9Y8N',
    'Hansapur':
        'BBTkyrQ+0w0B1JR/B4IrG1BlCwG/O1B9C7HpMmEpE3F6JhVb1UoJlDoVqFmE+GvM6BkGmDxC8MsMuIoI9C',
    'Janak Nandini': 'BBJ+zoQ4oz0BpLrU3H0C1M9HehEgOyB+I3f6LqJ6CkK',
    'Janakpurdham':
        'BBRskrQq8t0BlOoG6DyQuH6CpC6GjIf7H2PpPRrKoH9GvMnM7D2E5KzJvFEzN4QvUwOmE6W7H',
    'Kamala': 'BBO+zoQ4oz0B0HhY5Cpb+KlCHoL8Q4E/C+K6OFwGhGuQ0OnHwD/BiJxWyL/agD',
    'Laxminiya': 'BBN6hsQunu0BI+L3IlBlB+QrFoC/KjLhIU0BnGpHvB9D7PoNhHgOaoRyE',
    'Mithila':
        'BBd43vQ6lw0BnR2D/O5E9L0GvN3QpUiBwHhJjS/FiCzK9KjOyf7C6CzHyJ/BjDzHmSiDqBrHueyDkMuJ2HvHiB0K0LqIyJvGkMuBiOlTyI3B9GwVpS4DzHmLlhB8Q',
    'Mithila Bihari':
        'BBRwhrQ+pw0B7E5F+D/IjGlDwNxDpK5IvODkI5PmP0BiCyLygBmNhGoR1N5FyGiHjF4EzHhDnCyG',
    'Mukhiyapatti Musaharmiya': 'BBHsnoQirt0BzLqK6B+NlGsF5Z/wBmNuF6PvD',
    'Nagarain': 'BBJq9oQuxu0BxD2PngBzLUhdyLjN+MyPqJnFuI0F5GiI',
    'Sabaila':
        'BBUulsQm0y0B5hB1CtD/IqG5F7BlHnZtLuExQiOuCmCvGsG2BgC3IwOqCyE0E5GkBsGsDhBgKtIkF+WmBlImN8GqH',
    'Shahidnagar':
        'BBU0jrQwxy0BxMgF1UpPnC4GnOMuCjL/Q7EMjLkKuD6BnNmH2CqD/VsJyIyBjHiHgByDmSpEsFoZuL8BmHpG6F',
  },
  'Dolakha': {
    'Baitedhar': 'BBIuk8Q+oz0BhU7D/brc2VtjB4f+I6RwUxOqYjH4C',
    'Bhimeshwor':
        'BBPm59Qwnw0BnKyPhSkLnJmWpMvLjdzHqJtVkc5d1OtWsK5D+B3H8Y5B4UuPnEkKkGkR',
    'Bigu':
        'BBlByjiRwx10Btb1OjIe1O5iB9tBuBpd/Q3OrSmd3YkJvfgNzM/F1X8M3K8X8YibgPqK+jB4IF+IrK2RlC0WjP+Z2JkSxHqE6F/DkQuF2HoQsH+KyW+QPyBwH5V+EzQkO9J2BdnJtGlC1gBiN3fiB7E0GqDkgB',
    'Gaurishankar':
        'BBmBss+Qu330BvCrhB5U9EL/MxL7GvGpNlE1XxRrHtH3xBmVlcmsBgvB8mB4S2KtGuX8BmQ0jBkIdub2OjI4L4KqKlR8HG8UxTuSR6TmPkRkKJ8G2RLmLrKkEqBmHzHiJhrB+DhgB9HPtiB6KlK6C9Q3K3OnOzFjDkH',
    'Jiri':
        'BBYss+Qu330B3Ob/FsK5K9B5D5PnNpOgB9O1G7HxtBtZ3S77BrLnKsIjOkL5HwN4GgF4JsUmE0J0YtBoPwRkHmE2XwGqNyL8GI4M+UmF',
    'Kalinchowk': 'BBM429Qq9y0BjbzV/HpPqCjJojB3nB2K6D+J9ImI+D0O7DgG2X/M0M1FiZ',
    'Melung': 'BBL6k7Qknx0BlmBwB9a6H2E9hCiV8HsJnMsMqZ5FyQsIrDyHwEgG/H',
    'Shailung':
        'BBRmq7Qolx0BjGc4DlFvE5T/FgIxHvErIsD6FxQrMpZsU9R0PtqBsOsQ0Q+EyDuStMiG2OmWjcie',
    'Tamakoshi': 'BBI896Qy0y0BvT+V/MzRtclKzNtR4WrR8/B7GtUif',
  },
  'Dolpa': {
    'Chharka Tangsong':
        '3DB9Bw06R6p/yB5IkKB0U/NwC3D6IkEwM9NwO6JwR1f8LUzMvMtGwBjNpFpI5KuJhKQnDtH7OrEjewB1ExDkC3KlRvHhHrNnqB/kBtTuBnFtNpiBgC7N1tBwB1NhSxQsC3W/JteiN3d5GhMwJhoBwX4N0VzGkhB0G0Rh2C6N6C2OoUkUqNwUuCsMsU0W4R7O2H/QfjHqkBsFga0Z6I6KlHiemEmCiKsFWkQlZoYmLxJ8eoGgF8F2eiXqmBrHkfhPoHBB9QumDBBPaBBPUBBNQBBLKBBdcBBzBlBBBLJBBhBbBBLEBBPMBBxBABBpBHBBXGBBxBiBBBRyBBBXwCBBRkBBBxBuBBBVQBBnCNBBdIBBvBEBBvCPBBZOBBbiBBBTMBBTQBBbOBB7BDBB7BJBBTOBBBnMBBLyIBBFZBBJ1IBBFVBBBLBBNpBBB7B/BBBnCPBBnBCBBbMBBVMBBXMBBxBpOBBVwNBBW9NBB5BwMBBpBrPBBtClCBBTvDBBSsDBB3BvDBBhCsBBBlB2BBBdkCBBPMBBNMBB42B4WBBPaBBPUBBNQBBLKBBdcBBzBlBBBLJBBhBbBBLEBBPMBBxBABBpBHBBXGBBxBiBBBRyBBBXwCBBRkBBBxBuBBBVQBBnCNBBdIBBvBEBBvCPBBZOBBbiBBBTMBBTQBBbOBB7BDBB7BJBBTOBBBnMBBLyIBBFZBBJ1IBBFVBBBLBBNpBBB7B/BBBnCPBBnBCBBbMBBVMBBXMBBxBpOBBVwNBBW9NBB5BwMBBpBrPBBtClCBBTvDBBSsDBB3BvDBBhCsBBBlB2BBBdkCBBPMBBNM',
    'Dolpo Buddha':
        'BB+Bw06R6p/yBvJlQiPnHsHjfhXpmB7F1enG/EyJ7enYlLrUiZpDzKhelE5KmHlb7L5D9WkHpkBgRgB8O1HxOlOwP3U6E3SoP/NwfolBkmBrLuGgKuOtE7Igd4GsW4GsG2WvG+NwLuNiCvEiN0NkYsQ9HkiBltByXpJmKxRmK6XwlBomB2GsVjEwMnFnGuBzL5eyHtFkJsGiV7I+RhSpB7J8OtNqD5E4avLuHjLlC3C5GnNkC3L0S3TjEpV6QwD2NxJ4CzFwO',
    'Jagadulla':
        'BBrB+3+RipvyB9K4CnEqUpMsLxE4O5XpL9P8QjOgE9KjOvV+ItHhbtVqPthBnGzHthBzN1FxElTvbtB8Qxa7H5NqPhVgBpZ9E9G2hB3xB0L2H4DiQzEsa4OgoB2GqCwN5WoPnHwE6D8D3F6JkNqNiDgKkV6OF4G1JuRnEoJvMwTwGmIwoBtQMhIsL',
    'Kaike':
        'BBjBuo3R003yBnKhGlK7RvUtCjUpN1OnU5N5CzRi2CjhBzGrXmG3VpNvCpT8apW7D5G+OrsB/BjKqMxJmCvJqHpFiNqHoczG4W8DP/IsEC0X0IuB2H0YsBlGmM6Cga8R9DmIiGmQNkJmLjP8N5E4S',
    'Mudkechula':
        'BBSgk5RuhqyB1hB4xB+E+GfqZpPiV8H6N7Qya5T7dvKfzRmLiDnYgVnrBIxY1PxRmIpkBqJjE8RqIw2BwG',
    'Shey Phoksundo':
        'BBwCgxhSqq6yB3G1XvlBnmBhK3XpKwRxXqJjiBmtBhQiI9NnYwEhNtNhC9NvL1WwG3GrG3GrW8I/ctOuEtG/JpmBmLzEpLpf3e2GpYrFpS/PtM7KnB9HjbiNlG0GhuB2TlM2BlQsRzJ0kBuGmVpPuHibwV9IoN8N6QpHiLpN2XqLyE3OqMrLoEpU+K3C8C2H0VwMkIhH6RoFkEifmXwNgFgKitBxP+KuUuZCnDgVwK+SyC6b1IkI7K1ElHmJmBicgFgF1N6HmC4HxOmG/C6NhKuCvEmK4F6C6CuQyHuC1G+G4D0L9EuJnM5DjCiNsLwKxDqNjKnCjH+KFoS',
    'Thulibheri':
        'BBlBmm4Ro21yB5b5HlS2DvC3ZqG9LpFnEtT0CtB1HzXzIrEBQgJ3W7Dnc0GnI3G9IsCuBjxCzGhLoC/K5J/J+WvOkMpdqLyCwDxF+H8FvBqJkMibuUyH8KlGqI8JoMgW5NiV7DoSsYsSgSBuH8a0akN0F8S',
    'Tripurasundari':
        'BBZoj5R0swyBpUuJ1BmQzT+LjH+uBnZsHnd7T8DnS6NhVnM/VpI7J7KmG7U7H5M3e4M9N6c1MJhQ0J/PwCoMsNtM6KcgTge2c6BmE2S0N2F',
  },
  'Doti': {
    'Aadarsha':
        'BBa0p8R++sxBlBhTjKjVuXhXxIpUkItF4JsFiKhQbxK4HpD1D8C6E+DDgZoK8MhDiJ0MwG+GhFsFqS5I4BtNkW/HnB3JwRhI1JjIkD4CuR7IJ',
    'Badi Kedar':
        'BBgBu74Ry1rxBjM6EjGsP9M+F6B0TjJ8flOjI7LsFpX9MzKoH/R/G4C1f5HrKqH3IlF7BgGpI8NiBmH/QzZ1OlDzJoclL8GtW4IA0FrQmWF7DmViJsIjGyIkO4PqMoCsH/FsRmY',
    'Bogatan':
        'BBc+m1R4ztxBgSgH0KnHqX+M8LrFmOkIkJ7f5BzT+M9FkGrP8InB8H+gB9J2kByUoOoH0X3HX/fqhBjIQnC2L9JvE3SyOpSuD3PvL9BxQ1IzCgJrgB7P5R2C9K',
    'Dipayal Silgadhi':
        'BBa668R4iuxBpL1BAuHtKPjEkHpMvE/D0X5c7QrVqC4kB/rB7I7L8HvLmC+EkClD3E7KoUpMMvK8L5FjCvIwN+CpP4RkKkVkBoT/GkJ+NqRoNnI',
    'Jorayal':
        'BBawl6RsooxBzCkoBnVilBkD4O7GsI3M6CpShhB7H+F7TjJhG5IyF3LxI/F4F1RtVR5E7LuL/sB6U9TzGzMka/oB8J7CmIgZuPL4C4P8NwE6GoN5BsQ',
    'K.I. Singh':
        'BBQuh6Ry1uxBlB8HnQyFpF/VxUnO+J1kBhIxWqD/NqjBgXmSmBoK2JsHtGjI8K8I8L7e4nB7EN',
    'Purbichouki':
        'BBRqu8Rq1wxB9d5V1ItB9G2KtIhDpPvc5B3W0MhB6c8QgEzXqMwEkEjHuKQAtHqL2B0HosBvPmP',
    'Sayal':
        'BBW2t+RkhvxBvR3DjF5NnUyOxIjQ6DpcxN8H9NpRqHpJ+I0K8IK3CtRkIjDiI2J4JvRgIoByFvNkRjMgS4UheqRmE8b2K4S',
    'Shikhar':
        'BBhBkw9RutpxB7HoDcyKhKiQ3JrFjIuFyIqUrFmG5QxD2CoI7L6FLwKnUqMsFyGxCwHjC9ErHiHnK1JlSlBljB9WqVnRjD3OoVhlB0CjoBkYsB0ImUgOiLwEjI+O/FsG6NrEkKwIuCwK3K',
  },
  'Gorkha': {
    'Aarughat':
        'BBT6xmR2z7zBzUtJlSLBrRpO1GjChQ6MrOrCzPpwBpVgDpkBgFvG+a+IiGkOubX+HinBvDkSyJkILwP4Rqa',
    'Ajirkot':
        'BBT28pRo92zBjN4C9oBvJ5JwIlOgB16BnZ7TnSwGjN0T1CEzNiH1G2Z0T2QtE8RyKyVjC4esOM+GqL+IlE+I',
    'Bhimsen':
        'BBS08jR0j3zBzF4JQ4f1VmDpH5O3StMxE5OjM9D0RrJuNlYoU2EUsFoKxCB7TkGrL4HgTtMkjByBiG',
    'Chumanubri':
        'BB6By5rRmj+zBsI3+B7jBXvH4InW7Y3KrjBjLtEmRrXyF//BiG/HzJ7FlEpX0NpU2nB3Y6H/X0P1JsFhLoPoDiZ/G4CtHutB/CsP9OkHkCuG/FiN0E2C7LqM9L6SwU/DsGoGiUzKmJakiB/G4KjawP3H+WzVrGnMoazEubpY4vBmOubgBublJwC4G+UyFwGkIvCoqByoB9F8S4J2TnbkaegPjLwKxNzF1ExJ3RmLlWlDd3M9ZnIjDvV',
    'Dharche':
        'BBhBy5rRmj+zB5IsJlVapK4GpM9CpQ1INlRvMjVtO3I5GqDtSpG/F3QnHvBmCtE/TtS3OiHoGpP3RpaMvPxJjIAnrBmYnGmK9JgaXuiBrOmoBE7I2rClRsXkLuE4KsjBoW8YwH3I8jBY',
    'Gandaki': 'BBLwuhR692zB9VmC3DoIjtB4UnD5F+FxGjO7TqOnnBsT3EyMnR8c0a',
    'Gorkha':
        'BBS+3iRmg2zB4C9H7I3NzVC+ExtBhJlMvX9HgIxEpB7W0EmDmI7UyN0Q5B0ZitBofiOohB1F4hBnKyCTrF',
    'Palungtar':
        'BBPkzkRyzyzBnIoc7P4DvPwOplBrTxGrJgEhBjDrb9LrLyJvf+P9CmQ0W2d2FmHmNsQ7F',
    'Shahid Lakhan':
        'BBU+3iRmg2zBnP4YzRsJ7HlC5H/lB7cza2GtGtF/IkF7KxMpNkC3NoEkD2DpHoNHwQ2K+LO2J4OxFgrB0VB8I4N',
    'Siranchowk':
        'BBNiglRw01zB7kBxLjJ9clOvM0HyCwPvO8P3DoInc6HqTgP6IqVmgBhF6UzT2C',
    'Sulikot':
        'BBUw9lR8n4zBtE9NtbY1I9P5c1F+KvoBnGxSwgBqI0WuUu0BuXuUa6JvI+oBwJkN3CiBsJ6FsBnnBStiBsO/ZYlK+J',
  },
  'Gulmi': {
    'Chandrakot':
        'BBUgklRk3+yBtI+HrNLXtJqIjLnHnK4JxV3GjRjKiEjO5L0LzUoXvM4I0S8W1F4DpIpBmUwGyNta8UuEwfpII',
    'Chhatrakot':
        'BBQ25jRuz8yBrIiR7IzEzCnT3pB2NoGpL7CrO9TzLuCviB2J2B+QqQkQ6B+J2KN2JsQ7EwF0D',
    'Dhurkot':
        'BBW+pmR8w3yBpJ2MzS0JkFwKtM0EqCsL7NwFP5FnRZsJjLrRtU+FzPwJAxEtO8KlCkB3TqHgC0DkhBkUpL2FgEqH1HiGgD',
    'Gulmi Durbar':
        'BBTk8kRqw7yBjhB4XgB9JjHnH1S6DO1J9J1K7QnCB5RwOjL8EqFgI/C6G2GoLAiCoH8MvF0LwFO4OoUiJ',
    'Isma':
        'BBV8jlR2k6yBrItHyInIjMtBFvEuRzNvCjLsMvEhFzK+NrIkF8B/C0QkG4E6NX0H2G6O/CgF4GZgE5J7EF6Q9HuH',
    'Kali Gandaki':
        'BBUwtiR46/yBsNzJ4JwF2PnRI3K8NrM4KwGmDuM0ThKkHkJ7FmdnPmFvJqLnIpM7RMjBwK1NyQnJfjG/LrFW',
    'Madane':
        'BBSkunR0z2yB7K6WxLlK3N0QO3MhG/C7f8P1FrqBgD3D+JgFoI9F8C0E4HvM8GqD8D9H4R4E4TvJwFyS',
    'Malika':
        'BBSwjoRs34yBtK3EOwP5LPnFzI5OgDzH1G3NYlG3EX5S8W9c8SqGiHnUwO8JQoT3EgE+MuPhI2H',
    'Musikot':
        'BBUsimRoz8yB7Cpe3DqIzawD/EtQ+K9DHhTjL3HiL7PgEwDgwBjO8HrHG5QoX2CIjQ2IkH3xBw1BuGsUvF+OoF6P',
    'Resunga':
        'BBVuklRmv7yBnUhJtB1PzKxE7MwFhCnHnLAvEnGzKuCvH1K6VzMkRpCwNtR8SEmFwFnIoM0MuC1I2H2I8HxI0MkLqH',
    'Ruru': 'BBI+qiRmr+yBnX3UN3Z4yB/Pe+O6I4MnM6LH8H',
    'Satyawoti':
        'BBRutkRo1+yBlHvHxHiCha6mB3JvFlNyJ5D1CtE5OsL5W1ErLwXrLuWroBqNgKkKhE4GkR3JyVoHuK',
  },
  'Humla': {
    'Adanchuli':
        'BBOqyjSgvgyBoCrI1IhI2C5QtezXWvP+NsGs2BtoBgdWkCmQlO6kBrUiKkB+L5J8U',
    'Chankheli':
        'BB5B6/kS8miyBsKtZ2M2M2H7KuOwHyE+O4K2H8ThJpCqZsLmGsMlEgasyCgMsCoL6QqXzHyYjgBFilBuG2J3I0VxO4K0FoW5WiSQqJwJlBvBmM7V+WxJwbnFtBlL6OrR5Q9M3BrG1MvEqHjLuB5BzQ/PlDnMqFrGtXnRuHrKxJnSwKjL/BhLzLkMhhBnCvQvMvT0G5MvBxSxX0B/FjamD3W1OrhBqL6GgIhI8MKqa/YkLT',
    'Kharpunath':
        'BB1B4mrSu9kyBxYkgBpX0HnL5Q/LrC/ZryCrMmErLlGwDneqMpOnBnR4GrEtVlavS0G5O9UrDpcqKrPpBzMgMxK6hB0EyGlMqHoK8VmIzJoZwGiEwD0QvC2fwN2Y+iB2b4lBwJ6JsJybrC2e/QgLuPgUYsRmQusByRnD+Ira8K1P5LhL0FnOzL1GgGDmL5QsH/FqMeiQ1SvBrE0O/KlE9IvR9G8JtS9M',
    'Namkha':
        'BBtCoixSmm/xBnKlJvO6O/W9JtJqJ1Tb9G2FtJ3LjK+H9nBgHrN6NpPmDpK/H9BpS5QjH7V5W3BvJ8NzLuF7N6YzJvDzTzIqLlM4D9FtFrKgH3DvY5a9MJvJ7HoBxQvqD3LFvKvP4IlWsM+D8SlG4N8K0RvIsNxiB3JhMkCxP2Vl1BkSgL8XSoYnUkIod1HuHYyJwPyLsT2c+Z5C0GoK8MkFBzKmHuBwHsNuL5Q0SgGmJ1G2BwPgI4FgI7R2P4ErD+WzV6blH+mByUT+CuF8Ma5J+cyHqJqOjBvW0iCjIiD9FkMdmkBzH8KsB6Z',
    'Sarkegad':
        'BBdmwnSqkiyB7TiJ3K1HxE9OtOvH1H8K1M1MrKuZpMhRrOpI1S9dgYjMO3KmIvJrB7KsUhK2P5uBkK7G2ZuEwEiH/LyK8B4KrM0ZyImdkL2LkS7G2VoZzGyFoBoR',
    'Simkot':
        'BB5By4wSsujyBtsBxRrRlQ/TX/KtP1egR/d2BrH1I3lBvJ9iB1bvN1YwC1fvDzQvGhEiKjYpWpJpHnKdloBodzT4DmK6a+M4DwYsK/G+FuFmM3DyItLyD4TpP2JjIrB5GmP7N0L4EsO8S+RgRqH4BkSmK+HuPjDsN5N+nB/GkK9HyJ4L6G1F2TcuJpJmVmK2O1OiKyEpJkpBmHoHhFiI/FtD3M+ToF4OmJ+BhHuZmPoHuBiL',
    'Tanjakot':
        'BBN8/lSyk9xBtJkH5JlIvXiBr2BuoB9NrGqE5XvNlKIhWsWtYgYpByhBySqkB8H',
  },
  'Ilam': {
    'Chulachuli':
        'BBYqsqQg0y1BrgBqSzIvP7IxBThQsStjB4mBnL1CpJoF3H+MiKwKvOsKuDyd1mBmDidpPgT5K6HxOlIrIuEjEiMxP1FpCkJhK2CrF0WmJ6J',
    'Deumai':
        'BBWi9rQ2i01B9C1MmFhS1G9LyHDAjL6K9EucoIgOpJgfifyXjGgKrOwTujB9byL9MnFnPoQ3FiQ3VqF8BtbtWiBpMvK7IyH',
    'Fakfokathum': 'BBMg2vQqxy1B/JsO5XgGtF5KpZjU4HzDlKnoB0HjCmE2HoOlSgOgIoc+e',
    'Ilam':
        'BBjB6xwQ2g01BtO4LpC8JjLbpS6MYyL6LDzL6VlKP/LjM7oBuCwFmYvCqH7MoGxH1IoJ1WpHrJ8D3IjFwBjC5J6DnC7R9EpMrO6E/MiPW8IxHqMwK6VnBsDwMzEkP4VpF4FhQoPnQ+MoF+bxL',
    'Mai':
        'BBco0sQ6t11BhJsP7LnK/C4GnTgH9OvDVlGxKyGrNzE7IxO1N0FgDxHhI7b4EzHxMQ6BlOoPvWypBzRyIlPiP2G4E1H2LsRRyHxHE2G+LhH4rBqMsO2Q4C',
    'Mai Jogmai':
        'BBNkwvQqv41BlHLtVxXlZqD5UrhC8oBtCgMkMkRYkGqkBwK2ElB6H2FyCQsR',
    'Mangsebung':
        'BBXu1tQ4my1B/NqJ9ZrIvO+G9J1P3E2HhP1GxImPrM8ExBvPlJ/JsFtWiK1CkC/I4PyFkEhMwItEgPgIyZza0Isa8T6Hd4NyJsY',
    'Rong':
        'BBhBo+rQ6j61B3a4HI7L+NzJ3WrDrCzF8H/ClUpM+JpJ4YtCpL5JmFlG/c9MqNrMqHC9G3LgIpCtQzEX7F2D1FqMQHlKqL+C2b4a4P/BvJ4IhC0jBtJkFzE4Q0MsG3EyP+DsGpHC',
    'Sandakpur':
        'BBT0gwQk331B1FxCmB5HvK1EjGpkB9HO0MvW5LEbnLuSjNkLcqC7JuO3LiTgW6F6R+B4wB3K+L3I/C5Q6I',
    'Suryodaya':
        'BBfo+rQ6j61BuD1IqHB9DrG4ExPzMrG0E3QuJjFiCzjBwJ3I3PgCrgB5d0V/GgD3G8LoK4M3Q9B8JqHsJnJ2WyGwI0N5F4CxHqPmpBmZpDuVyXmHMxOsdvVrJrS+P/N/FzSsW',
  },
  'Jajarkot': {
    'Barekot':
        'BBjB6u2RorpyBzgB7GnE8F/b+CxG9Z7LtP5ME5C7ViG3HgKkCqH3jBiG3B0BhKyRtG2KtTyU9IwWzakPoS4JWmNqMzEmImHmL4J0BY2L2J0FemVoEsE2EnD4DyInH0EuC8JhG0NiEoSjNklBzwBnM',
    'Bheri':
        'BBZy6wR4jnyB9NzE0MvS3W9XyEvHriBpEtK3N2C7PwGpBjFjkB0HnJyE4L0SvKiXiE8RuR8GgcoLuDoFgNiLuBuMwMnPgF1CuI1NClJ6brOyE',
    'Chhedagad':
        'BBhBy9zRu0iyBpZkCrLsMjGnJ1B4J7N4IuIyI0E8UjT0DvC6I1N3G7G/b7RtRhXhEzSwKxE3L8CxIkGoBlE3MiFoBkVpWuOqDuFzvBkW/foJoCqL6RzC+SqFlEyDwE6DoUxGuZ2SgHwepD',
    'Junichande':
        'BBV851RgjjyB9IjFjW2IndjSrFzUjSgErd9F8Enb3EzWrIY8CrR6TvOyX7GqgB2JiPkTghB/C+EkY6SuasJwE1L2TpTmG',
    'Kuse':
        'BBXoj0R2kmyBpZ5UpUxB7M/M7NpEoC3PkTzDzE7UtIxI8N3I2B3JkGoJsLrM0ZhCmdkS8V3IiWyYiD8MpO4ShT0HlM4UxRuGzBiK',
    'Nalagad':
        'BBjBy6wR4jnyBmDlIsOxEmJ5b2NBmL1M4buBqZ6UpH4jBvP8BEwMkCkN6MDuMoQ+CmWkL4EqYzKwgB8GjI8kB2Q2WpOq0BvHhW5TnSjM4B5FpHvQ+BjK1GvG/PoD3J5NvP7FhTnf1apExnBpO5GpDgE',
    'Shivalaya': 'BBKktvRqriyBvDh6BsE3mBsfzQmTpYsKiKgEwbjWggBhF+uB5OzC',
  },
  'Jhapa': {
    'Arjundhara':
        'BBay3qQiq31BlSxH3NhP1Fgc7ckB/GhV2FnDtBvTpG7CxB/L2H1DqKqE4arM8IyFuBoJsN0EyKxGWmGyN4E7HbQ+J/PqBY4JyQgFjI+B+G6L',
    'Barhadashi':
        'BBVqxnQmz11BzFkLnMrBnF0GvIpSvNhBegJ5JuBRiM/H5JpMF/NtKxFmFzBlGiC7LmHwCgG5JqWiFsG3IqlBmBqRhK',
    'Bhadrapur':
        'BBW04mQ8541B5J6DzEnI5LgDrH/HZoF9SqF3HxJ1OuCJtV8OjD7D7PyR8LDuG6Q9IkNsF+ajK+GgHiGxD6D8LgJ4F1SqQ',
    'Birtamod':
        'BBOmwoQqr31B1R0BrMkK9P9GxCwDmHpdzOhBhE5S4HgByDvG6KuCuIxM8XwH4HuK',
    'Buddhashanti':
        'BBQosqQ4941BhWuHxT9EmchNf3I3XGa5ZkLvB0F7b4NiPmSyH1LoL+c2MlFmGsLwJ5Y4C',
    'Damak': 'BBMkspQ+hx1BpLiFvLpE9O9QzThJnIpSuQoK8X1IqmBqIqJ2OqMyFnLgJ',
    'Gauradaha':
        'BBYogmQuxy1B7I/CzLwHtJ3U2G9BexTjGtN4MtKjRzDI3MwX5KkaiC2TrGqIwMjHiLmG8EdmKmW6Ic8EnHgExRpErS0QjJpEHmU',
    'Gauriganj':
        'BBZihmQqsz1Bxbb5KnJ8D1P/K7H7RwBlHnHpB3GgG/DnGzIgD3GmJpH0FtW+PnLoHyEvC8JiRuD1M0K0FsJJsXvE0E3C9D8JoW+O9HqJqF',
    'Haldibari':
        'BBWo+mQyy31BrX0HjNrF5Q+IEtG1NnJxErViExBnI/LoLjIU1KoUyEkI4JO/L6JtBd/IwNiB4GkPpEiCgE6S2OkBdmQ',
    'Jhapa':
        'BBVsjnQ2301BtdyG3I7DrG4IxRhGvHuEwMtPrGxBhIlRlJiC3H9HoC5MqGeoHrL6Q4LsJzEolByN2BoOkPgCfwHpHmB',
    'Kachanakawal':
        'BBb07kQwu31BjEhDnByKkFqFxO0CpDuRrQ3K/JlX9Q1CtC7NsFxJqOR6PnoB2I/GqJiFqB7PmL6InDsGlHvChC8L0BmGkFnFmHgDpB6NnL+HoImMhEyB',
    'Kamal':
        'BBWu6oQo1y1BjSxN/gBtC1WsQrSrC2PtKIlUkJqEsSzQ0YcVtFlW5IelKlG7EkH/K3DlKmJgS0TiJ+O+QwLqEgN7E/TijB',
    'Kankai':
        'BBQwopQ2u11BhM6HpKpEnKqKjLxD3LxGiG9d1ToDX7HqHlB2BxI6GM8C5I0qB2RgG5CgIic',
    'Mechinagar':
        'BBe04mQ8541BqQtEkQ9MuClFxJrIiHxL+YjEoDsF2RiBZ+Y+MhDkM4FToG5b4MwT8EiWtHmUqM7HgDsC0F6WuE/NyIH8L7berYhMpnBjE3GxLpPxHrRETxK7IE',
    'Shivasatakshi':
        'BBS+lpQws01B/F6CxhB5Q3JT1C+IjW1BvBlOjHqBjS9L0D1XoOEsUvPghBuCgKgL4QgE4IsN/NmgB8L7B',
  },
  'Jumla': {
    'Chandannath': 'BBLmi9Rk4kyBxdyhBzfjSHhiByDzDqC+EgJ5RkU3KsU4MmEkM6PpC',
    'Guthichaur':
        'BBfgq7Rk/ryBpY+HvN6WvH9C9NrnB0Era5DnQxLvH7B3KrZpDkNjlBhEnSiGzNpChK6QzJkHkC4E9RmNA4FjL2OpCkR7V+iBwV1UgmBiI6d/UkOjK+QyFyapDgPoHsM3B4f6F6B',
    'Hima':
        'BBPk77R4qiyBxL1mB1kB9pB6H3FuHtU0U/NgJsIHqM4ewR4LwR9B6MhJmJ8CsGzRiDIqV',
    'Kanaka Sundari':
        'BBWmx+R29kyBnR3DrWmIrH/Jgd/oBlB/O/QxQ8JrhBiTrV7GhR0FjD2VmCoF+UgRmJA+QlHiFmOkVjBiW5O0LoH0RnI4HtRU',
    'Patarasi':
        'BBmBgq7Rk/ryBH1H5F5B4B3fnHrMqD/OxFxakK9QgVnOhI1d2U/lBpDrDydxhBsHgKsWlIoR4DnG6GMkTwNmFwGgLkC4hB4W6H0JxD6HoKjKmdkH+Nxf6P9EoNsf4nBxtB0K3FucvTvGnJwMtRoE/G4JxOE/JjVpNhD',
    'Sinja':
        'BBSkw9R6gkyB5PqClEjMjX3N7JvesNrMHpV0RhD7CrGiJlJyBlQ4bvD2M0VlT6VzIsYnBgJ8S0WZuJ',
    'Tatopani':
        'BBmBgl7RynlyBjR8V1OqC3FkLlNA3E+R5QiD3DxI1EoDnErEdlV1JzFX1L3JzBlHlL0ElIlNpM3JVpLvRtM2CzMpRjDxKkH7RwTxGyLvRo5BoD+egesN5B+H/T8UtDqT2FwJ0LdkO2HsJrSkL/I6RpC9ExD0D',
    'Tila':
        'BBOs57RipiyB7V7H9VqD9HgUrN6Btc3cxTrCyV3pB0MrC8EnZ2JzFqWsMogBwnBkLgZ',
  },
  'Kailali': {
    'Bardagoriya':
        'BBOi1wR6yvxB9TnBtYjPvJ+CoB9OpF9E2GlCxF5Q8PsHieA4DwO8EtE2YwB+MgS',
    'Bhajani':
        'BBd0ruRg7txB3B9D/D6F1bzD+Dkd3PhKQ2O9ZkDvOhT5F7XjFauG9I0GsJ5EvRiFD8BjMkGyG3GzHiFvPwM1CoSwGuNnDqI3JgImK4ExHoM6FS0L4I2HnK8T',
    'Chure':
        'BBlB4r1Rq7qxBvFkNtO0CjIlHpIiFhsBhZnJrP8J7Eb3H1TrM+JrX7DjI2SpNsXvCyBvHgI4FwW5C4P7oBwIuBpDvK0FhDpG/QgD5H6GXhBvJ8atHqGyK8JXgY6Q3MqXkH4KlXyZrMkiCrIXpKmalRuBpIkH',
    'Dhangadhi':
        'BB2BiyxRmrnxBmCyI0JzB9J8IsNiNvM+OrP1BH2FrH3BUqE3Y6JxG/C+C/UrMwFnO/E9D8FlJzDlIsFzLiR3F9DmChHnFE0F5IrElGgMnPmKuDUvLiKsBsNtH9EnK6FhGtC3SkIpD7CpKkF8EqD7KyLuGsK7dqMvC5CgGiHgHoJhNkKuLnBtHoI9DN4X0MwSlJ6B6HmPjI8HzC7GpY4BwC8MuKnE',
    'Gauriganga':
        'BBsBq3yR2mqxBnS/E3KwR+SsU6Q6BlK6PzpBwHF7LvNS7N9OpC0FxI3D1N2ExNpFqKtf8J8J6Q7GwI9YzIrC4D/P6T5E+FvH8JsDoKlIgC1HlNxMkK/H3JmBlCxImLiC2DjKqLsIiH7GzChHufgI+IkLxBwHhLnC/eiS8DkI7JwX0ToMc4H7J8E',
    'Ghodaghodi':
        'BBc4kxRivuxB5WqF9FtP7bejSrM3OwDOtQkLzR1JhKuBt2B8DsJ8IjMsF4NwSuH0QxEyI4DqCzF8N+OwNRG8LyjB7HuUyE3D+GsHuf7OsW7F4X7PnKtNqJ',
    'Godawari':
        'BBjBi5zR2wnxB9IjLnfhIuCkHhH8GpLrIpEqK9MjGnLoEvC7M4H5D8QkCqC6GkI7H5HlPmJ5BzMvSarY+H4H+WrYwKyEM1GgO/GypB8I6KxaoY0M+LxC2B2VzX8GW6J/GemBmmBvItB3P8oBvW6C',
    'Janaki':
        'BBSo7uR8jzxBnWxR9hBzoBqSlMe1c3JvEhDkIlEhFrCjlBmPgMwBjEgMuI4KF8EmRgGkC0B6UlL+eiP+jB',
    'Joshipur':
        'BBS8gvRo9txB7EwD6FyO1GmC6FqIlDmMlP5BvEsG9JCnhBzPPzO6OgKwClDvF9Z2b0DgE5FwBgG6C9D',
    'Kailari':
        'BBjByovR2nrxB7HnCrF3N7IkM1DvJpCyqBhMpF3EyHrIlK1KiLlVdoHzTvD9IjJwC2DnN4PhSqCvQ8LKgEvM8JdoDtL4F+D0TtWsJ0D4IzFuJ4EqMvF7CmVwO1BFiN0IsCXwE5L0Z7M2B3J7J',
    'Lamki Chuha':
        'BBW4xvR60zxBpUzM3Fhc1JhPpC9LuGrLhE5DqJ3TjCvQ/FjChGhTsFpEygBMgSgN6TkB8M0P3BqPpHsDiM4NtgBoqB7LgG6BuO',
    'Mohanyal':
        'BBjC4xvR60zxByIrT5BtO8L/FugBnqBxL/KwJvQ1NtUujBvP3TnUiP8BuNpJ8PoK8F3X6O/VpH5f4D9GrOlEmK5P5Q5B1S3TuHnPoRBiIsLmsBiZmIhFkImHuOzCiExMoHVuNiMjHyQ7NhB/FqImF8BpH4I6HsK9CkhB5LiZ7a+SBgNtHMnBmKpLoIqE4OuI+B+E+I9R+I3I9C8CmNrL2RsEkDkGzHoRsCYwEvHAxLkQtJpB1D0H5JjK1J2N3LLrJ2I9JjDrCuK3N9D/FqJ',
    'Tikapur':
        'BBXijtR2pxxBzNxE/Y/f5CvLzL9C3RtQ1J8E6LpUjJxB0K3J0H0K0GzCpEtGkE9D4N6D7CgDkMmOqdnBiDwiBmEiFiDjI4JwEd2c',
  },
  'Kalikot': {
    'Kalika': 'BBIqw4Rux7xBtkBnB5FnYkE5MnI3K0MhfmayCyT4Q',
    'Khandachakra':
        'BBTwi6Rwz8xB3Q5CjR8P3OrP1D9bkOzgCxF3I2WoC6H+P+KwF6KzCkG4GlJgU9KhGb4K+P4X3BkGzKf3D2F',
    'Mahawai':
        'BBcis3R0w7xBokBayB4frI0LqGqTjDgXhJ+E7G0Z0G0V/ImBjB4N1KiOkEwJkIzD2XuE/JoYhHoD9hB5E1QhR7KvQ7E3X0FnGtBnNpIxKwIhhByUxWxE3TiG/V',
    'Naraharinath':
        'BBP+x8Ruo4xBzsBugBtpB2C5LqGlUrP2G9S+JzGT/PoNrH6gBNsIkIoOnFsGtO6E8J8ViP',
    'Pachal Jharana':
        'BBTu16Rg69xBzZz2B8DjG0KgB4BjG9P3Xc3K+KiG0J/SwVyjB4KtK+F6EqcpB6OmuBjHyEhX3D5EqN/YwB1BmM',
    'Palata':
        'BBVgk7Ro4+xBxOne4P1K2BlMgZvB6EpNiX4DkHxEiZsHoG0GhC6MsoByKiF2WVsP1KiL5D6c/gBhEpgB2D5GpO3evR/D1T',
    'Raskot': 'BBN6z8Rml7xBhcuB9F5E3KuKlThf8ThKwHnKmV0UoClL6FmFyG7EyK2P1HwD',
    'Sanni Tribeni':
        'BBU098Rqy6xBxK1PxG8E5FlFnCmLlVzUvHoK7TiK7InM5K0C9KvFlFlM6LpG4pB5C0sBpgBua0VnGqFsJ6F+EsXxJ4S',
    'Tilagupha':
        'BBYwy4R0ihyB1XtEjI0DjEvJ2KhOkB3NgJlBzGzV8GzZiJ9EkD/WjG1UmInK4OsPkW7QmMsE+gBqlC3JyGvMkZhLNxJtI1J0F7EoZzMsC',
  },
  'Kanchanpur': {
    'Bedkot': 'BBM+u3RmmhxB9nBvEpdrOhVrqBslBtboagKgSvFqK4InHqE6EsQtE+K+H2R',
    'Beldandi': 'BBJ85xR40gxB6C1MhP2BGhL+HpSNzPgQ/D6MqL7PkwB',
    'Belouri':
        'BBU85xR40gxB7LU1HkTyF8KgNnElKyMG0O1NxBxF6G5LnHjekTjHdpFriBoXrc+UrFqG5YkMrNiO2GvE2SoPvB',
    'Bhimdatta':
        'BBayw3R46+wBvK5I5RyFja/Jzf+ZhK5B7CnNgPtG4ChLwIY8EtG7C/FkL7M5XX1Bxc6nB0C1BkGuRwLmCpH0cuHsB/Ema+JqVuYlfwBpM2PrGM',
    'Krishnapur':
        'BBiB87wRuhlxB8Ut/ByYsEmXoWwIxG2EvXzDpQlJrGwJ/DmJiBuC4GgQrHmC0FwH3BwuBoRomB4V1L+FV6FhNhEc2I1I4Cvc1NtL4a9oBhJ/NgHL2GvKxE9WsY9E1I7IiDpB8J1J1L/JqN9G/G',
    'Laljhadi':
        'BBXoixR4vkxBhW1BtEpLrLV4BlK8QrfqLC5BpG2IvJ2NyBFzOoKlM3FvCyStJ4QiImDqMtH6D+X0SwDmQxEsXzI2GlXnWvYtE',
    'Mahakali': 'BBJoj2R0z8wBhjC1G5JgF9Q3DhE8EjCjUkItGuxB7D4rBia',
    'Punarbas':
        'BBV87wRuhlxBzM4BvDoHB/I7P1Wl3BqL9C2F5M/HgV/WnBhI+X5EgKrVkHeqelTwLmHhB8I1LOrSqpBsLW0EsL8V0B',
    'Shuklaphanta':
        'BBZuk3RmvjxBnmB3VvuBnRvH4BlCzF/PsHtC3G9SyC1D/H1K3DwHjE5EhKgPtH2FuD+E5KmWhK+RoCoJ2N8LxBmHwN8RlBkeiRmFtEqCmG9MwU',
  },
  'Kapilvastu': {
    'Banganga':
        'BBXu66Qos5yBzCxK0HtPjGvGgInFtD1EsIpK8OmCNvP4FoCyG7M0T0MhF3Y2N8DmdnK0Z4N9MmUwEsDpJ4kBqD0QloByK7etFzW+G',
    'Bijayanagar':
        'BBY6w6Q6zxyBjOxBuI3O9FtPyFxO0P+E2NhN+Ua2NpPgOiE0J3H0NyBgUzHmB4Q8JqF7I0T1ROlH0HzdsJnK8QlMkCC2F3M5ChHiF',
    'Buddhabhumi':
        'BBlB4q+Quz2yBpQrGldoK1N7DoEsZ3XtTbtO5OYtDuFpL3D9N7d1OxFuBzMkPdqDhM+E8DgL9DyB3FjGpCuD5I3I3CtCxMiM7FA4K2O2FwJlOqY0BiI0GmLvD2BjGuJ8EiKjImagD8Cg2BsRwOzGnCnhByW',
    'Kapilvastu':
        'BBasj7Q663yB5ShQtNE9I+H5S9NHzL+FmCmDhLzKtK6GpKrR3FgFpNgL+D2D/NiP1E0EwDrB+M0OoF+N8dqL4DuDtF6OX6F0UxG8M3FnCSqP',
    'Krishnanagar':
        'BBNou6QwxyyB/OjG5C8T/Ya+BxiDuJgBgD+HgPpHwJoEjF2Q+FuPvI6NmOwC',
    'Maharajganj':
        'BBYui6Qq90yBhHhE/M+EtGhX1F0LnHjH1MhB+VzTZ7W+PiDwJnEwCvTwO6F0H+P+EBkEgKhGgFgBiKiKiFpDgJkGqCxLwJ9F1D7DsM',
    'Mayadevi':
        'BBRy96Qqj4yB9mBwGrQrE9Q2GnD0JzHjClFllCgIwJ0L+BgG5L2EqC6DwU0S+NwJhI6PwBiCmHsO+H',
    'Shivaraj':
        'BBd23+Q6qzyBla/ChKkItJ7E1BkGlLwDhIzGjY1BnH+M7NnBnD7N/FchJ9JnHzPyC1d0UsHiHhF4M6CB1FmMjCoK7Q0drJmHzH2RNmJ3T0B0fhFgB4E0MqLgB',
    'Shuddhodhan':
        'BBTu66Qos5yBvRxJxcgSjOtHhO8DrPxGxIgJhI7I4W/R2B7JsJgHqD1J+Q1G8jBuDuH3G4PsE/HoFkGwGzHuP',
    'Yasodhara':
        'BBTkn5Qo52yBrHtLhEoMtOjC/HvJ1BhW4K5tB2MiBoHkHsFzLiFwExB6gBhL7DpGiJuDyHoPuC5GqKmK6N5C2H',
  },
  'Kaski': {
    'Annapurna':
        'BBjB2zuR0vnzB5XoExQxUlY7J5X3YjIuKzlB3U5eLlG5IrONpD0L9EpBV8VjUmB4F5QlHrUiJjfyCpEkHyF0EhIkKiI+YneuQ7ByOhO3C+kBkHvB5BvHkLrI2XwN8IP+EuM0hBijB0ajRiIgF2O8mB',
    'Machhapuchchhre':
        'BBeystRqpqzBlJtFxNgF5nBvWvnB8KrPpU7NnIgI/KjI7IG5N3KnExL7QuF9EjGhK4DtOvHxO0LjV+PgBgFqIueK0lB4UmH7K4YmZmY8JyQyU6XnE0C4N/MkQ2B+O5O+c',
    'Madi':
        'BBf00mRgtszBbzcoUnftI3MWnG0BgJkD7CdtRgnBwH4MzSgR/H2dydwnB7K6nBwWyN/EyJ4FGogB/Q2P3DoOzKsCvEstB9G0KhM3HhGtMhLdhUpT7TqC/qBpTlQkPhNgCtUrC',
    'Pokhara':
        'BBpB6opR2/ozB/QgI3M0S/mBvH1BuUrDtH2HqW1GgCnB2L/KyMxKnCtIrQ9K9EnRkLnFlS3SlSwLrb8FWEjJgKtIuG+BkH1NMjfqPlEqQtUL5VuL1LrB5MyLvLgX4XvF8b6NkCoCnFyJ2F1D2OkGiKtF+EyL8Q4KoEF6NiIsI',
    'Rupa': 'BBM00mRgtszBxH4PpFrD7TwJvK/GtRsFiHrkCoHoHyPpL+K+EuIsQsJhB',
  },
  'Kathmandu': {
    'Budhanilkantha': 'BBH2m/Qg2j0BlsBvDlMrVwRDzB9EgG3CsgB0I',
    'Chandragiri': 'BBHs78Qyyh0BlJ3N3TpEyF/QyQzUkWsF0GuO',
    'Dakshinkali':
        'BBN+97Qy1h0BlL+HpSjCpBtH7FqD3JhM8ExO8ZlE6F3IwIyD4EuEpCwMiH6H',
    'Gokarneshwar': 'BBKgy+Q2rl0BxGhZ/M9EzIjQ5HE9FpUuSkJ4tB+EnDwU6EgS',
    'Kageshwari Manohara': 'BBKwv+Qoml0BlNqC5C1LzXxWjO/ZyNzB2GgT6HD0IkQgN+E',
    'Kathmandu': 'BBMw29Qwsj0BrcBzNtL+P5b9IhFgDzLiV+ByDuGgK7C3C4SuJoQvRE',
    'Kirtipur': 'BBHm68Qo2h0B1D3B/C0LzVvHmIvMtHxKyToD',
    'Nagarjun': 'BBLu59Qwgi0B9EAyD1H9IiExDtGnNjElE2D8RjkBuLtHyFuhBgIgC',
    'Shankharapur': 'BBLsw9Q0wk0BiPmMkDiM+MzCwCuF+H4mBpRkU3FfDjQnSnIjGpf',
    'Tarakeshwar': 'BBG649Q6mi0BmW1kBiXyboC0UlQtEnByE',
    'Tokha': 'BBHyk/Q+9i0BrgBzInDmEtKtUsgBsNoBxE8OuD',
  },
  'Kavrepalanchok': {
    'Banepa':
        'BBPo58Qsln0BzG/MzHgNlG/LzKwDjN3LrKpb4InEnD7EiF5H+QsK4EoKgZ4HxFmVsGiH',
    'Bethanchowk':
        'BBPm/5Qmln0BvIuOdtIzI6B/WnSNnWuGlNnUhThHzT2BrN0U8W6iB1C8BwZ0RiS9XmR',
    'Bhumlu':
        'BBXgq8Qy2p0B9N2HmJN4M0SrHyjByC8MrI6FtMtEjF3Q5PU9FxVhMjN6MhJ4F8DqLvMwBzK6E4EwGpDxF5CkKgC+IrWyKuC9MuO',
    'Chauri Deurali':
        'BBP2j5Q03r0B4brMxBxHmK9QsJpDiMkN+FyV6PT0JoTxK0O6BwP/I4InWxV9BrMnkB7E',
    'Dhulikhel':
        'BBR8h7Q8no0B/b3mBmOwFHnGmN1K6EqKkCpO8EdkNgM8KrDoGgMyH/MoCkOlOiGlGgKrT4C+C2S',
    'Khanikhola':
        'BBUk24Q46m0B1KyFGuMlXxH9IjKxEyEO3FtV/OqEnR9DnN6DgE2H3FkE/GzEpGkOhK3E9HwInGqOqB4OilB+OyJ',
    'Mahabharat':
        'BBc2p3Qskq0B3VlM3Q8EvFnJiFrGnH5RwMzJvF1HrD7nB4K/PpEtI4ElK4EkEmDtEF0LqV4OVyF6ErE+IkKuX0HzPkM6L+PvBkLpKyByJ4FzB2YrHqGzH1C',
    'Mandan Deupur':
        'BBPgq8Qy2p0B3CpI+MjOxK3CgBnI2Y/dtMliBiGjKuauCsMiMnHqOwC6WnK2GzHiZpMyP',
    'Namobuddha':
        'BBRy36Qm4p0BjG3ChV4QxP/GkPnYrExHlNkIgDjbhEzIyS7ToFvPuR0M6O4YnG+FckJlGyBwOoN',
    'Panauti':
        'BBa6x7Q6kl0BjJgG4C4G3IiE4MmXvH8EjCqO5EpKlN2KIoG9SnG9B6E1J/Q+XlRjSzTnCxW0I9P5B3HiLpKwGoJ8RQ4CkJjImFoJuGuHvJyK+U',
    'Panchkhal':
        'BBZ0p8Qs9o0B9IsWjK/ByF6CvGqD5E3EvB0KpLwM3F7D5F0HpCpTmOhXrOjMiG1CVzJmKhDgJkFrB9TsT3CmG/JmOhGDrFmLmJsD6MzY+d',
    'Roshi':
        'BBbmt5Qogq0BvM2FH2H3VwRxKoUnc9KyItc3CzHwL3M0H2CsHpG0B1YxJ3FqKxBwBjL5L9P4PnMRrM2KxFgXoS2IzBasKpNgOiE0IhD+aoN9HuEiI',
    'Temal':
        'BBRux6Quvq0BrJqDlK+QgCiH/QyKjcyMnLhDzC0HvHhL+IhWka1XyC3JgL1D2P4FuU7QuFkDc6V',
  },
  'Khotang': {
    'Aiselukharka':
        'BBQ453Qimg1BhL+CtLvKpf/F1C5W5Vja6XhG1BhJ7NhIlE3P2vBbsCksB0K4LvCoL+EwJsP2K',
    'Baraha Pokhari':
        'BBR0uvQkig1BpUkGxD9G1F4P2GmHzS+C/NuTtMsElBhiBpO1YiI7fsY5G6UoCyK/FuMuOvDoGwHgG',
    'Diktel Rupakot Majhuwagadhi':
        'BBS6x0Q+wh1B1KvL1a6B9H7btV1dT5U/IvN8ShLHxPwI9J8e+G8QsfjB6S2NiCqSzWyF2I3M0tBLkX',
    'Diprung': 'BBJmvyQsq/0BjL4QT2mBtXnH5hBjgCvGneiexR0PwZgZ8M',
    'Halesi Tuwachung':
        'BBYu/zQ4t90Bhf7GpI8JIyPlVmL3RrHjP3X6TrUmU91B5K5e1M9K7H/ZkClJkR9IM3LkTiNkOwb2DqVsV6TvBwTqG6FWiO6GmB1N4c',
    'Jante Dhunga':
        'BBT6+vQ+ni1BhHvDhIgO5NnGjHyJ1KK1gBpN+BzMzGjJuMrEgOtT0S9C1GlH2F3PyD+G2TtGwQunBlF2JiN4G',
    'Kepilasgadhi':
        'BBT6x0Q+wh1B6VjYMjX4MztBwM0N2C6W0LrBse2RyMhBRwkBlQ4CpO2M5IpEpI8ErDuJ3JoBvR8W7HnMtS9K',
    'Khotehang':
        'BBN6+vQ+ni1ByHnOhN3GmF1J7P9lBlD5atQ1aof5EuJ5MwGoe2oB6qC7agnB1I0E',
    'Rawabesi': 'BBNmv1Qsr+0BpS0W1NhCkB5S7Yt1B2N/c2N6cmSPwM0MgEqPiMwF2BiJ1XiF',
    'Sakela': 'BBN8yxQolh1BflKyR4GU1mBkL3QqVghB8H6bibe9QiSvMc1UvKtImGnRvD',
  },
  'Lalitpur': {
    'Bagmati':
        'BBTg85Qwli0B5L6FvHrGtJuC+EqPnS0FE4XxTlE7H+PvM3H8M3T4S79B0XxGoFzIwO2K0FlM6PoP5IqPxMlC',
    'Godawari':
        'BBVwm7Qmnk0BlDzG5J+BpMjH5HrRahclLeNvYrFnEyMmCiItSmPmVkGjDoBsH6RyMnEuMuEgHqCxD2CsNrHqDI6L',
    'Konjyosom':
        'BBP+q6Q62j0BlLuK5IrCVlPlJ5BkC3Jla9IqO3BhEhSuJtCwHsG6L5FL+KwJ9DIwd',
    'Lalitpur':
        'BBQ6u8Q67i0BxC7FnJMpFyKxHQvB1JnC0DtE/GoEtM5FArG9KoRXmG1GyKiJyHnD+LiH',
    'Mahalaxmi': 'BBJwm7Qmnk0B8JlfqNjHoC1JqMnBe2Q7EBniB4uBzI5I',
    'Mahankal':
        'BBSuq3Qw4j0BmMqH8H9PyTmEVpWkGrC2X4I9BoK4IgBcuP8IuC+B0H3GqO5jB+CtU9W5BkH/QtF1F6F',
  },
  'Lamjung': {
    'Bensi Shahar':
        'BBf4roR+kxzB7HsBhR/M3I9PpM0JOgSqM9DpByM3YgF1NxI4EtFxMnO+M1D3C9F+FrItG7F6JpX7CpIuNvDzFhU8FzEoPwQsD+RwM9H8BsQ0F0DuEpGa+KhIqDgL+KmG+R',
    'Dordi':
        'BBiBwmpRiw1zBiB/OhJjMxnBxZlHvKvV3D9IiE9D7Q+I1MsCxUvPvBjCuL3G9D9IkGvF9jByesL4Y/EqBxMpM+DN/R0MxJgEiMwV6Q8HrBiLoMqQqdFoP0RgNyGsM+fuJ0N6UiHpCxF0PrwBwjB',
    'Dudhapokhari':
        'BBWwmpRiw1zBpThI7RmD1VzLxQuErbjTpYtjBkXpHoC1MxJjO8C7DgNyBkCtLwPwBrCyU9I2M+D8Q+IhEwV4DmHwKynByZiJkM',
    'Kwhola Sothar':
        'BBVg6nR89uzBjOoHrD9R9MxQyHvIzGxFuBxeikB8BmQjPgrBqT8TpC8P+KrFgK9LI9W2UtX4CzD4HxMzS/H+FwFygBlN1I',
    'Madhya Nepal':
        'BBTy7mR0iuzB/I6EvFlEtB4W1HkC/MpHoDuGtFqE/NvBtZj5BichJgKgHsUvJqFsD2JxRmJiPrFkMgCqOyGuF',
    'Marshyangdi':
        'BBoB4zrRiz0zBhHqCzN5U9ftJxGrM7P5KxBtRla9mB+BxOtGlUrL1LiIpDZ9KtEqGzFzDrBrMwI7HmN2IvFxgBgI9FyM0SiDtHgYhD+W1U4LDuGvH2D+F2KYmJkOnHgM0F61BuEV5CyPqJiL8TwEsE4LpGoMjYqSmGwlBiH8K',
    'Rainas': 'BBLsnlRqtzzBtMtG9H5RWlW3HgGlN5D0iBvf6QmGyB+agN4WlFqP',
    'Sundarbazar':
        'BBU6imR+pxzBthBrI4LzWrG7sBgOwBuFpEnDtGgNqH2HjCuB3WqIqG0DyRtN4D8CqI5JqXuG8F9FsI4C+FzMyCoMsP',
  },
  'Mahottari': {
    'Aurahi': 'BBJ6htQ6ts0B7d5KhJ3SoNe4JhVoO0MKmOsJoC0Isa',
    'Balawa':
        'BBR63rQs0s0BhUlErE8EpQzIvN8HzJlIIxJwC3DoP0FkB7InHnJuI1E2KqGgH7CgK0NuVqKmE0K',
    'Bardibas':
        'BBf2ttQ64t0BuD9G/NlN2JsEG1InM/CvB5PmTgGzDhKunBwI+UwL6HzpC4xB2c2BgHya1CmTwTlF6LhI7EtM4QgM4MpHsNvJetPiUlL7B/JwGlLpIpC/KtG8HhN1JvdpDxBuH',
    'Bhangaha':
        'BBV2ttQ64t0B/QhEjCmN3K8B5dzE9EnG0KhPhHoB9F/L+O8C5B7N4JPTlPyUoBmM4GtEgHwD+JoMgDF2I1JrEgOmN',
    'Ekadara': 'BBH+2pQuur0B9M8I1LnKyC1H9KyE0C3T6czC',
    'Gaushala': 'BBN0ttQ6ps0B5DzQrJnCJlO5H7E0D9HwS+H+FrR5HjHyBvN8kCgW5H0pC9UvL',
    'Jaleshwor':
        'BBTg+oQyus0B/JqEoCjJ3DsD1K/GtJ6HpM5BWlIuNhKwIlesHxC0He3B8PwLjEnD8GoFgExHmDgJ0KPmK',
    'Loharpatti':
        'BBQqxrQg9t0BtMB1P3LnBrIze9L+D3Q4IoIiN9HqQ0IsE7EiUmE6B0N9O7C+FgMiHnBzKiP',
    'Mahottari': 'BBNi5pQkts0BzMwGnFvFtEkJ3E1I+G/PhJlL+H9CyNqGyFpI+Q4GiCoPnPzF',
    'Manara Shisawa':
        'BBMkkqQgzr0B/P/GDhZ/DuExR/DlPgJ9FxDkWzP47BoG6BwhBhGgDxKpG',
    'Matihani':
        'BBPogpQk7t0BpEvFpJoFrQtahO9F4D/MyPpHgL+GkE9CtDkIuF2EhK+JwH+DuC+J+IiB',
    'Pipara':
        'BBPozqQ0rt0BxW8HvOlEzLoMjB1L9IhBtC9JvH9D6MlTyH0JoEnJoFwF4K1DwD8CrFiK',
    'Ram Gopalpur':
        'BBO+jsQgjs0BxGgGtVpKpN/SE3N0KoB8G4LqGX/DhV2L0CmB2H4TFhH+R7N1D',
    'Samsi': 'BBMmvsQo/q0B3TGjBzHxI3DWyW1GIrG1L/J3BF/NoQSoPrIUqI',
    'Sonama': 'BBJq4sQ8jr0B/c9T4N3hB2HvC2ZsNkCqS6HkHrG4RhSpI',
  },
  'Makwanpur': {
    'Bagmati':
        'BBhBwuzQ46j0BiRuEyCrJ6NQ6R92BwcpM6MiC+BqTiIoLiiB6PtP0a4DkV/N6JuE6G9KkMhM/G7EhMxIfvCjNlHtEjX+L/JibzdwEegKjPkEIxNjHsChEvHrG0IpFxNiEpMwL/C6G3f',
    'Bakaiya':
        'BBgBwo4Qwoh0BrRg7BhiB5PhInL9BpT5MhCvcqM5R+2B5NPxCsJ7RnFiBjUkH7GgG5ZjD7c4N1Ld3lByL9S4WpTqS4BdmK8RY1CyTiGwYuYOqNnHwBhN0ITuF6KqPwBrEkUjHiE',
    'Bhimphedi':
        'BBiBk16Qk3+zB7FWpHkPnIsuB3E1B1FqOzO1KnF0InMJzM+IblPmJ9IiExX8NIkI5TFtU7IxOvN+IuH3YrV5J6CrMqF+B4GzKqBjSgkB5E+H8DxB8KmGiB6EwO2F/K0J1DsO6JxIqfpJwH',
    'Hetauda':
        'BBiByv5Qg87zBtF4FxTJjH+bjGnB1aqRkD8GrMiiB6F+IlF6E0B8NlciIJ5c7RXelKrJzDqC3Iqa9MkC7QvI1VQ9K+HlDxG7QmHrLjD9D6oBgG6P1MyI/d2K0BuI4DvE+LmLyD/CyL+OmP',
    'Indrasarowar':
        'BBP465Q41g0B+EN6C3e4M3e0UqB+CgHmSxFzNoVoJoL6WmK3IsQzO9F9HwJ9V2BrGyO',
    'Kailash':
        'BBVi78Q6w7zBnWgOnP2apanNzJ2D1FgL5EvOlGhByB7K9SvEuPteI/R2HxL6OjH6MoJiInK0QOkKiLsI/HmPsL3Gyf',
    'Makawanpurgadhi':
        'BBZwz4Qyhg0B/QxCzEtKtIgBlB+MxSyJlT3CzBxHMxHuHzE+SxDzB7NmF5E5F9IsMhiBtDrGsY/OJ2JsV6JtH4YoNhJkJ2OvCggBzFsI9LvC',
    'Manahari':
        'BBbqh5Q6k6zBjTrFxIgelQ6MnpBvHgJtbsOrPSvP+LrLhB3OwN5LiPsO+bqHyKhL2IN4CjayOtVH5K4MuLgP8B5OwlB7GwIpLhDzGiHaoGrH0BpRgV',
    'Raksirang':
        'BBa4t8Qs75zBrIgIhLrL7PB7HmK3QrIxS6RHgShLwR9OlPgDxLnL5DqL/hBqR/UsHzB0FlNwL+C2V/tB8RnLwL8ID+InFlB+F2O8SuP3J+EmNqS',
    'Thaha':
        'BBWur8Qolg0B7djQoD/SmIxHlSyF9C/G3O/BSrQ8DzOwH3CyIpfqN6C8NhaoW/NsKgOBoNnGmMgF8E3JyCyNmfvZ+ewGgd',
  },
  'Manang': {
    'Chame': 'BBJqisRmiuzB+GzKwErtByIvB6I0M4kB4YnOoJb8RvNqP',
    'Naraphu':
        '+BBqB4u0R2nszBlG0lByE2M/M8N9IsWuG8LvIgJBmY/DyIjOvFauL1GoKjM/BlFqI7OvFnB3M3SoBvGnRlK6BtMnnBvR7E/GjX7PjV7kB5HifpdyWrEkWpnB0JrHoNiBqDlRxFlR6N1V4RVkGyHkRlGuIyOwM4CsE2U0X6GjEgM8E4JlK8QBBoR2RBBFoBBBAPBBL4EBBJoBBBHeBBHcBBBOBBjBgCBBDMBBCyCBBDWBBBzCBBH8DBBBaBBfmCBBLWBBLaBBFUBBBOBB3Bz5BBBDyBBBRWBBrBmCBBkBtYBBHsCBBDQBBPoCBBPoCBBNkBBBVkBBBDoPBBPYBBJzOBBDmPBBLlOBBBsOBBChOBBLmOBBHiFBBNhFBBP2FBBPQBBJMBBViBBBJYBBFSBBTUBBVcBBT0BBBlOvtBBBCTBBnElTBBFbBBdyDBBAgGBBRzFBBJMBBDKBBFQBBAI',
    'Nashong':
        'BBlB88xR8kxzBlO0btH+GlKnGpM+L1C8LhNzEtGgGjHjCrP+OttBgD3CuH9Q+ElZQhH7KlGvlBkYpSoGhShMxJjMbpJhL6CxPtEWpE17BqI5FwrBicuM9M4CpV6X3LkViH8PkVgHkXwR8EuMonBuMD0E4PsStB',
    'Neshang':
        'BBjB8wyRkipzBpMkHjGxH5RY3N0VyFmRpDmRnNhBzJsHjWqnBxWsElbwchoBvY/D3HyF1OoRjQRxgB0P9P6O9c1B9O+M/PxCzP0HjqBqZzN2Y5lBoN8O6HgUzC8LkN+Q4Q6DmLga0WLqGyHR8F3KwF',
  },
  'Morang': {
    'Belbari':
        'BBOmgpQw6s1B3rBhM3Z0FwEjI1K1IyBnQrJxPgmBrMuRiPoRxGwMiCqZoclK+TrOvE',
    'Biratnagar':
        'BBRo2lQyxp1BtNxDrDvSrSiJ7PoB3IjG9OkBjCoFzF7Y6TE8H1OytB2B0IoEyDiMVwJjGwC4H6E',
    'Budhiganga':
        'BBQq1nQgkq1B9EnHrO7BrLxP7jBhN4FnE7CtVqJoBiB/EwX2X8KyEqKzDqPqJlCqK4G0EvKqB',
    'Dhanapalthan': 'BBNy8lQgjr1BxI6J7OL9HgXtNgH1NhYjCxY7GpMqSpDe/EsRMgH8K+WqL',
    'Gramthan':
        'BBQ61nQi6q1BrREzCgFrC3DvM2IlRzCE5NyIlC7BlF3GsBdhP5MLgG9cycgKsMqQkPoC',
    'Jahada':
        'BBRy/kQ0mq1BnTtBdgFpSqDrM3H/QmBpI5K8O9RnD7GiFnHqFgKkCnF+OjB4IkGkLtC/B6O0RoN',
    'Kanepokhari':
        'BBNk7oQq0t1B9VoE9U1LvpBqEJhJyJvIhLnJxBpUyZ0F9BwMuZ3F4rBiM5EoB',
    'Katahari':
        'BBSkkmQujr1BlFqDpD/KhXrLzG9QzRnN0C1NmZtHO0QgQyH9EYOoI4MKiBoP0HdY6H1GnClE4H',
    'Kerabari':
        'BBWgysQmlt1B1IatP1O4C5c9NmGhgBjC9MwG7c/a9CtI8RF4B7NtEzD+H3d8N+Iuf7JwU+PoSftCuNyMsO8CsS1H2TyJqf',
    'Letang':
        'BBV+0sQo8t1BtJuJtJ9DtFyG5uBxIrOwUxaySmEvavNkBF1xByEP2C9NsOwEmK9TkN6HqGjHigBkC+NlG3C6cuP2OyIrB',
    'Miklajung':
        'BBPs2pQ6/v1B+G3RtLhEzCtHucrhB+wBkHuFxGuJ+DuJtJBwhBtd0mBvKrDvKwO9MhK7EsR',
    'Pathari Shanishchare': 'BBKmpnQk6u1BlK6DtM7UsQna8Sd8P4KuVpEiBkcjIsMjPgF',
    'Rangeli':
        'BBVw0mQojs1BjRlByBqUkL4KnNuPlK1G7FuE/BvJ7J1GxQoO8DuEhSiJ9GrDsLxuB0QvEmIlX0OSqI5JuGgF+JxEsJyP',
    'Ratuwamai':
        'BBX+2mQ83v1B3fYvdwJ7OsN7MRlGvR3HejHtoBuI9BwIyNyRvDkBhI8E6CgFxJ0OrBoOIKmFmG9DmKgI+ItGiTsNoJlEiB4S',
    'Sundarharaicha':
        'BBMg5pQmyp1B9H4duE0D3B8Nre7BnRyGtOnMElmB4K/B3GzEmCpKuc3I',
    'Sunwarshi':
        'BBao2mQq2u1BrJrF9IuGlK/HnG+DHlFvcgBrF2J7E5CjBiIxRwD3J7NkRld+GsDiShJ7DtEyQnO8J2GgCwJ8FtE6J8GmBlF+P+H6MzF1GmWhHuE',
    'Urlabari':
        'BBOs2pQ6/v1B1jB7H3X2I3L3KnYyBqTxKb7SyjB4H+Y7X+DgPrH8M6MlD0CuHoLyD',
  },
  'Mugu': {
    'Chhayanath Rara':
        'BBkBorjSwkmyBppBnI7QmP0H2PxOxE/LoDhPqenNpKzJyD3W5HjC3hBvG/KvNlFNxSsOpZuRToI3HnHzR6OzL9BvQwOphB8IlEqFuLqXiGlOoO6HmUrDiT6HsBqK1HmMoCXngB4gB0HuDqL5KwM2OshBlD4W',
    'Khatyad':
        'BBb8zgS+1hyB9D5F5LuG9IqX3N9SmHhFA9Q/QlJnF9U6D5c4KnLlE9kB4cpMsD9PsCqLofwL8WpFoGtK2G4ByC+JnjBmmBqD6P/GoNiEqKhEgNqE0ZxP6T',
    'Mugu Karmarong':
        'BBkC0pgSi4nyBuLtHiJ5WgMnDyOyEzH1P8QlP2sB+JmUpDwBySzG6MwMwToCwQhMmhBgLwLkLgCoSvKsKyJoRtH4FiX8M9EgQmD8CoRyOrJsG2MsNkC2fokB7JkVlOoC/GqLjUgLpL4YhVjNjC2LuN+jBrKsIlCgKxNyG/M3QfjKvRvC+DoiB7FyIhS2CrJukB3G9D3J0HjZCnLxUhtByP/E/JlXvNjEhf5RnFjHsHzW5MhEpP7H9B9Q/bgIxLwQPpIhoB2F1c2tB1Krf3nB+EnNyf5PjH9N',
    'Soru':
        'BBkB45iSoyjyB6KvMtDpL3gBzHYogBlMnCpK2H5HrBsDhT5HlU8OtM7DhGjU5BrBzF6KsCyP5TpEzZiE/MhEpKgHnNpD5P0P/L8U5f/BurBiegXpCuR2IiIxBkKkS4c4TkOwJ2S/CsJjLUpagZ7MJ/HiI',
  },
  'Mustang': {
    'Barhagaun Muktichhetra':
        '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',
    'Dalome':
        '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',
    'Gharapjhong':
        'BBWyxxR2vmzBjP1L7BpWnTrdpPtrCwM1J2DhP+Wue4EvQmkB5X+GtVyEuCIqXuJoHwNzBsF4KsC0hBxiBqL1D2sB9EqChKwkBzJqE',
    'Lomanthang':
        'jCBrBw/3RqoszByJpZzM1OoQzUmfhUkJ/NJ1OpFpH3hBpOrT3V+TrIopBznCwMvM8MpDwOpZkGA8D8ekR3BsPuL5CiW2HsF+Jie9F8XuJqM1BoItK2PtI/G/H8WwJgK3JwQoE+Q5HoPpK9E5LuC/EyPgFkgB1EuGlO/BvE7NtNvJ/hB6HpEsQzMOBBknBtoDBBFfBBD1NBBFeBBCwBBBXsNBBQ9LBB1B5GBBM8OBBGjGBBEyKBBFSBBPWBBFxKBBG+DBBZiHBBS5HBBFlBBBRrNBBNgXBBRzXBBD6YBBDaBBBMBBHnaBBDgbBBTtbBBIucBBACBBLcBBDheBBBJBBDZBBkGkWBBFfBBD1NBBFeBBCwBBBXsNBBQ9LBB1B5GBBM8OBBGjGBBEyKBBFSBBPWBBFxKBBG+DBBZiHBBS5HBBFlBBBRrNBBNgXBBRzXBBD6YBBDaBBBMBBHnaBBDgbBBTtbBBIucBBACBBLcBBDheBBBJBBDZ',
    'Thasang':
        'BBc+jwRkvjzB1O7D1ZxbldhOH/PiEgDkK1czDzK4O3JoXzB0GjLgVhKuFyH2IxBgWuNuLzB8RhgBrC+UsPkb1GnB/D+UlkB6X3EwQ3X7d7CwOvM2JqD+XuGmH',
  },
  'Myagdi': {
    'Annapurna':
        'BBiB0wqRu1gzBqZqEkKmLyDvNkftO8duKqJ/IgLiDsDuKjK2chE/CIgQmdiO2Zyb0HpBwOsK+Bgc1Y6lBpZ0NjR/oBzF9CzakRzhBhjBvDlLpKXtMzKrL7C/KsI6BwHtHoBmDxsBjRpFxOrNwUzT',
    'Beni':
        'BBQimqRingzB7UbjQiS1KwC6LhY1IlRuHhF+DpYyTtFwHyPmFrFoH+BGrI4DwPyIjBiFwP',
    'Dhawalagiri':
        'BBtBqqwR4s/yB0FvSvDnIrvBzYpa1B7M5NxS2U9NsEvHoTwD4JhOzGrF3IyJhW/IhGnD5PqGtGoBzQ5XyFihB/mBlK5P2OlO+K9avBjLsQvJ4L4GyChP6SvY4amI8UulB+D6BuBrR2SmJqSmB0GyK7MqfgKuerC4WiSyQ2DgkBuP+jBrLqc5GwEtL0B/VtN1IyB',
    'Malika':
        'BBXw+rRu09yBpVwF1DrKvR/B6E/MxEzHpYvF6HvNClRlK5OiI1UmeoL8I5NyHpB+CkLyHoGiHtCuCgK0ImD9hB0pB6XxFnB0QpGuG',
    'Mangala':
        'BBT84qR6g/yBxIkB3DvPFsInH9BlFsFvHxPnUkEqF1agShUOzQ+XoF+E8H5EgNwRgCuDmKmG3BtL+LjBkP',
    'Raghuganga':
        'BBeqqwR4s/yB/UiKzGkLnX0B3O4J3K7CpJgJ7dtKjfuOxDwNjKlLxUPpPlS8X3WhFvP2J3NkBjP+MlO8NpB4IyFpJyWuTsPvD3JwHnT+NrEyS1U8M6Nqa2BsvB0YwDoI',
  },
  'Nawalpur': {
    'Binayi Tribeni':
        'CBbuy9Q8/mzBjdhN7QuP/EpF1nBwGhIzE9HgHtJxE1BtO1HpIqU/VxJ9GuZC8BxRmK9K8JkJ+ZmEX1eiHvXpI1KuB9HsN4FqWlR7FmgB+JyhB3JgoBgQZBI1zE+gB9E0GhUoFsEuRnJ3FnI7YkbxGkFvG',
    'Bulingtar':
        'BBa08+QqvuzBhC9QpQhNuG7TrFzYzJpOwN5YoNd8KhJ6HmG+GjE0OqKtD+E5E3EYkVrFI+H2KCiSxIyE8EyCnGuH2FsBU6H7IkRsD8O7L+I',
    'Bungdikali':
        'BBRmggR+6qzB7YnHtZgMqBvM3G9LoKtW5I9RmEhM8JuB+TwQ2MhE4JkF1EwPiNgRlC4M9EnDiCuI',
    'Devchuli': 'BBKoq+QqxtzBrKqG9a1J9YmIlKjrBoKvP0hBhLgUiG0JqOsF0Y',
    'Gaidakot':
        'BBP08+QqvuzBrHoJ5WyHtCsIgG+M+P6JvM2ZrhBmInPpgByNxUrWj2B+YlI+a2JqMjGsO8M',
    'Hupsekot':
        'BBX8t+Q2/qzBxNqX/NpXpd4BwFhSnagCtDxJhNtBoC7SoOjCsM3VqSIkD9QgHViBtYmHjN8MsQmCib2N4ClEgM6I+RnKuW4G+L',
    'Kawasoti':
        'BBV6h8QgrszB7Q5N5I9azhBnN0EtR0J8BwIpJ2PLkFmCpCuIiNuBsDwJibpB5F2GiD4M+ZzDqMkWhRvF5MuH5JzB/KoF',
    'Madhya Bindu':
        'BBaqx9Q2knzBlHkNhBuY/GWrDmRhSPrM4VnOkCCuK1LtDzR+KzJ7BsBhKxPlY0NvS3KtrB6IqCiH7GiI0EialB0NpFgFqF8QtPyOsI4C3D6LuI',
  },
  'Nuwakot': {
    'Belkotgadhi':
        'BBO8vgRmkg0BnlBjC3GxLvT1BvGxJtDrY0I/FoO/mBwM9G3EnSkVwE6G8HgDw/B+T6V',
    'Bidur':
        'BBV2wiR21/zBxFuCe8brIlI3FiElUnexPgBjE9KhSjPZjrBwWoT0KgB4L/ViI4HsO7F5Gma8F6E7B4G0IpGgHsC7EkF',
    'Dupcheshwor':
        'BBPoniR+xl0Brd4DjXrI5D1d+GzgBsU/G4GiHimBnB3FkjB0K2JkLlCP4LrHoFAtH/GtB',
    'Kakani':
        'BBO28/Qmzh0BlRiH3CnKrC4EzG3E7EoDxHnHrJxgCuGsJwT2B4GyLolBkCtH6fjQ+H',
    'Kispang': 'BBM2wiR21/zBnClhBkJtCyM9PlE7X+lBkNkGuViJ4E9E0dnchXzG2GnFmb',
    'Likhu':
        'BBP2xhR2ig0BzG6I5HvCuD0KxFyBvB8X1MhEtJwOxP/FtB3F+P3HiPt1BgGyGoMvD2HmH',
    'Meghang':
        'BBS8lkRs39zB9kB3NDkf7J4J/GpGnMkH7EpTsJ7PpVJ9F7kB8OqEsBpFkN+MmM6B0F3R6RzIiCkb8VuS',
    'Panchakanya': 'BBJ+qhRmoj0BtVmH8CzVtTbwB1bwOjV2KgF0D1DmE4F',
    'Shivapuri':
        'BBTw1gRsvj0BxGogBkDkazHmB7L7L9Q5CiDlHxHhKsNzOlBhItGdyGtRhHD/E7LqE7dgP7E6MqExEshBuTc',
    'Suryagadhi':
        'BBOqnhR6uh0BxG3W+FtEtDzK6HwC2MxImG+M4FhEsImI5F2doLwI6CkMrX3BmB9Z',
    'Tadi': 'BBJi3iR6tj0BjsB9BzDh9B6WlElB+ZsX4BYkNmNqHwFgR',
    'Tarakeshwar': 'BBMiwhR2r9zBxJgV5MA/UtR3DrW3G1HxGkCJvFoL3EgF9KuXkC+R2K',
  },
  'Okhaldhunga': {
    'Champadevi':
        'BBT422Qgp20BjNqGZmKpQnKnL2NlSlP3B5R4G7MrbvIwJpK5OtWiIxQ+XiXiJxBgKqQySzH6HmEAiY2KuE',
    'Chishankhu Gadhi':
        'BBNun0Qkh80B8CneiRjBgDtQikB5BualJrNuQvPgETi2B0IqNjb2E7H5L9PmC',
    'Khiji Demba':
        'BBQin4Qiy40BhO/H5Npe7F4EnDjO/N3LjC7MgPsBsPnagNrG0ClUkwBkzB8D6KlGodhS+MpB2K',
    'Likhu': 'BBN422Qgp20BY7U1KtEmBzW/IzFxS0H/JlMwM/PklB+B8lBwV7CyU3MgGzPwa',
    'Manebhanjyang':
        'BBNk3zQo060B1T9V7DzV5Y9mBgMnHwRhZ4EoI+MQiOqXyJ8B+KusB9K0RzBqR',
    'Molung':
        'BBT8j1Q8r40B8OvGmG7J/CnO4TtSH/KwHnGiFqQiMwIoDkOyG7D0P8frVF7HmcnVzL1HgEL8ShQhRpC9U',
    'Siddhicharan':
        'BBb882Qqm60BtamJhkB6B/CuQhRkB7CoexJtIhHjkBkV5B0BpR6K1PzKntBwTqLmNnCuCkViQiRM7SyFiBe/EuWyL8Hlc0IlDqY+IxFiI/GtElH+FqCwT',
    'Sunkoshi':
        'BBV8j1Q8r40BzC+DhdlOnOtX9MP3EnIyF1UqQzBsClTiL/RsTsLkFnC3G8MyBsRyQsPiNtN2HSwJgL9S6QmCiQlG2J',
  },
  'Palpa': {
    'Baganaskali':
        'BBUu9gRgvhzB5JsGvNhBtMvT9M9GbhOsJ1G2F2F8I1HiL+FwH5Sif9HxGuFyJkU/HoCpEqQwEoKnDgGhFrD9B0H',
    'Mathagadhi':
        'BBe6l/QurizB1OiJpG+M5KqBvCghB7NmFhGdpJzd6GnfnXoQ9M5FiSpa1B3TyI/HuCjO2FgBhD9GgLzHkMmKQ4KsQJ0F/J+Y9BVsN8e6b/SiNrB7G5GiExD1D7DjO',
    'Nisdi':
        'BBdyv9QgokzBgTvDyCzF4FoNzDoH2NaQqMkN2OzE+T+RsFpCuM1MqLyKsUK+MjHiL4LnD6NiIc8PyG5BpDqG3JjF1MiE9TvQxXjElChb7MtQwFpMLllB/Pa',
    'Purbakhola':
        'BBe4ugRm6jzB/K4BTyFgHsDvBoMrQnB/KwUsQ6MjF+FsDgLnJiP3C1I9RrF0E9TjN1OPpM7NnB6D5GvHlLoCzdmL7B+LtSwKpDwH0IMuhBkL+CoItUiW4FRoMzGhC',
    'Rainadevi Chhahara':
        'BBgB44hR+58yBtLdjVwQvQ5D4FvQjNAhK/GmHhFShN5nBkEjCpGhP9BkGvX/G1KAnQ4RhBgDhIuLwBoJvKsF4KhD4YsP+NkF9FqG4Q2E+BmHrNiIoBoFvIgKmH/BoS6QwEiF4Q',
    'Rambha':
        'BBYu/gRm8jzB1Q/B0C/F0GiCSnMhW3FnIuUjL9CLthBhKpMqE7Z8DkOyD2D6GhEuEmHwDhHoe/M0BsN0P+M9G0E2E+DnCuSxM+O8EmB',
    'Rampur':
        'BBaohgRk0ozB7Q3K3LoDkHhLJ9MxKrUwYrXb3RkF9FtQzMiL1UsQoBjD7W2dqBxD8L5SiU6CyI5FsPoIFhFoIoJgMxMwdkG4ItFoGiCmOjEuO',
    'Ribdikot':
        'BBW6whRkp9yBjEkV5F1GxB+PlKuM3UsD9drJjC9ShIkFoIpPvNrG8SvXvG3FkDpQsP7ByHiGtIiPuWiFvGmQoRkEkVvQ2JT',
    'Tansen':
        'BBYmvhR6s/yB3JyIhPcvH6ShL9F/I2HxF1FlN0K1M1V0C/UwIVmFlNuFqEB/IsM0E8crCgLnNyB9P6F2GkEjVyFiI1KogB2D4N0H4B',
    'Tinau':
        'BBhBii/Q4rgzBxN2CzFgKrQKP3KjMlK/K0HiD+GlGjCgPpsBlD/rByJ7G7CtQ4I/JxI1LsOpToPoCkCqG8ShC1DiPwG4F7SwXwNsGnIqPyDiC8DhImC2SmJ2FCgJtFpElFmNrJuD3BoS',
  },
  'Panchthar': {
    'Falelung':
        'BBTwyzQ6/21BxcqErRvH5HjK5PI7BlFqC1T9HpekNuI2D3QuTjQgDpSoT/C2GuHgIvG0L0CQyhBiJuJxNwV',
    'Falgunanda':
        'BBNktwQg3z1Bha3pBoEhYjRpRgZraqFuCf0I0Z3LsI+K0ExCjGsZuIiIlRgF',
    'Hilihan':
        'BBP410Qmty1BxOrGvEomB3hB4FrEzWlLhNc5RlJpToDlH+T+EmH0QyLoE4b7oBkLvCmH+J',
    'Kummayak':
        'BBOwkyQ82w1B9ehDtI/KzZ4LgBzIpFtC1JsOlHrtB8DvGqNpC+CtrB+mBihB6Lic4I2G',
    'Miklajung':
        'BBUw1vQ83w1B1NmM3a5VnOmSlE1H9ZxD3MngBPjhB0P/OAtX2KgGsU5GmQqChJ4RxKkHrBwPgU+oBiNEiExMoMzD',
    'Phidim':
        'BBS49yQ6tz1BhRgD/DoUtSmOhEiRrgBzjB1E1J0Np+B2RhGtIhIsGzXiQkGyI3DmJmNbuT+GsHW0V0JoJ',
    'Tumbewa':
        'BBO2uvQkwv1BnM0DhEyMhND/T9oBsBvPyKjH+LtZ2MpM0Rkb4G8DkKzE7EusB5N4C',
    'Yangbarak':
        'BBZwyzQ6/21B4D9tByN7VhJ/I+CzN5G9F+CtNgK5GsDrkByOsGkI0mBtE2S0EwPnCqjB8cihBiyBiToSiVnHyHzItSxZxFxWyP3T1PzGiC1ElIzWP',
  },
  'Parasi (Nawalparasi West)': {
    'Bardaghat':
        'BBZmq5QqmmzBhRtP8D3P5J1EqFhJpCrRmJ7ChNnPqFvHkI2E8EjE2SiMgD/LkGBibkQkM1IkkBR3C0oB9ZlEhJxJ/KsL7ByRtZB4IkJvT6T',
    'Palhinandan': 'BBK6w4Q85izBlR+MxJAT3Iib76B+K7CrCmb6L8F3IyU9H3B',
    'Pratapapur':
        'BBTwz4Q6jlzB3E2L5QjHtE2EjDxKzR6EjN5ImT1pBiIkChDiF6FmImGrKgIwD6IzH4KqKoHNBkIrIMqCqR',
    'Ramgram':
        'BBX+g6Qo5izB9WM9D+JnV1JsD1F+H4B4IxU5L7FmEhcsH3JgLoDgInHkJgG0RjB1ByJwHoM9KZvQyWsOoB1GgIoM4GW6GjP1D',
    'Sarawal':
        'BBV2y4Qw2jzB7O6G/HvDlGsK5FlIiDhFhIjC0K3W0C2KuZnP0UiK8D9JiQtBoa+KqTmThM4IpgB5Q9D4M1ShM7EkEjI1E',
    'Sunawal':
        'BBV4r8Q61jzBpjBcpPpQ/VzIbvIkP2DV5GnM3G2G/HrOnBwQxW+KavHnM0BnSyZzE0eujB6R+BrB0M/QiT/CiPsI8K',
    'Susta':
        'BBU032Qw+kzBkN6I0R5EkDyKuE1E8QkH2E1LqJ4CtEoO6RwR/CkKtE0D7FrOjFwGjbyGxH1R5UuDzBqUpIjBzStZ',
  },
  'Parbat': {
    'Bihadi': 'BBM47kR6ohzBrV1EnDkKvRInBtKlIuC5FnI8O3RcpKgSTuK8R2S4J',
    'Jaljala': 'BBKy1pRq+hzB9mBgDxBxNpJpHK1Oka5DgT3T2UW8KwR1GqS',
    'Kushma':
        'BBU8qnRg2kzBrF6GtOnQelHpKnN4BtQoL9hBuRnByT7kBsHySgGyB4BwPnQoLiI0GpGmR7TpFwLoI9DsJlH3EhGiE',
    'Mahashila': 'BBLsslRw9izBpG1BtKuPlH3H9J1iBpJmH5DlKoGzY8WoCC2UmTyE',
    'Modi':
        'BBW8qnRg2kzBjEhkBiGhEmH4E+DrJvLnI8TqFqGlRhIzGwQjN4lBpDqP0NkRqFMwHhPuOtQ8B9YoejKhI1EiIlHxFxIuiB9FkB',
    'Paiyu':
        'BBQujjRsjhzB+MWoBuK+QHlFyP6DmKqJlHwByRuIsIhD0D5NgC5GzL7PHvJxX2D/MzH/E',
    'Phalebas':
        'BBO+ymR27jzBnMiGpPhEmB9RlMnOyBxcrT5ES3SiH1JgP4SiYImP2MgBoT9LuiB',
  },
  'Parsa': {
    'Bahudarmai':
        'BBP2wxQ+o5zBlRqC5dxL0L3O0IiDuFtE3CpJuHzFmK+EvEoMoNhB6D2Fc0F/IXwFoK',
    'Bindabasini':
        'BBNsrwQqy4zBvNjExF+E1M5KzB5I0GwByF5JxF3GiOwC2JzE3EgS4W0EgB0K',
    'Birgunj':
        'BBf87zQmu7zBrqB3LlXuG1JrIrLZ5FhKhIoHgBrLxQ9K9HRUqL5LpFtQ5R1B/O0Nf6I7YqK7CkIkGtJ6L8F/B0X8MmRpC5IwMiHgIoOqByDgXwIiEXzIuHsBoEuHgoB8L',
    'Chhipaharmai': 'BBHgwwQmn2zBhUmDmMzkBkSmCuP6R9G+DrM5F',
    'Dhobini': 'BBJk0xQ012zB1IuB3ExIhH6D9MrGwD9TyM2FgN/G0PmF',
    'Jagarnathpur':
        'BBRi4yQuo3zBtP2E7M5KnBoZ7T5GArE6JDkE3K5MjJ0LzEiM1b2OmF4HlHsN2KxG+G7N7BtDsY',
    'Jirabhawani':
        'BBQ8k0Qg63zBzPhBlMvK5MkEzEnMnMjEuDrYmPmBqFhGnEtIiXuG5CmO3H/BkG0FvDgJkY2H',
    'Kalikamai': 'BBMwpxQm52zB7LCyD8PvJxCvD6FxTpKoHzXiJ1DuM6KqJhD0EwI6IrB',
    'Pakaha Mainpur': 'BBHsowQqu3zBhK2EvR/F4QvkBqL8CnI2WmHkD',
    'Parsagadhi':
        'BBRu8zQim7zBnoBhMvKtJNoJlLzGiE9L9EvInOpBhH/HwLzM1EvNyd6D+K+MwCnE4L+BhBmGiawS',
    'Paterwa Sugauli':
        'BBOyh0Qu/4zB/kB7FyGlK/MexLvWhQ4BoBnZyM4K4PzEsF+KgE3F0HamMwK0PiB',
    'Pokhariya': 'BBMorxQk33zBtQkOnXhF4F7V6XhBjGpLsFjGkJsBgBwH+JuE/DkL5JE',
    'Sakhuwa Prasauni':
        'BBRu+zQui6zBhavSepG1TWrFlL9TnBhFhNvNgBwEnMhKhGiLrIwWiG6IrDyLwWwNLhH0JglB8F',
    'Thori':
        'BBTqm0Qul3zB/XxHsDjJjGzF4HgC8D9PimCloBkN1yC0F7DoJ0M0C8VsFpCvLyPlO0yClG0I9KXnazVzEmUhRlF',
  },
  'Pyuthan': {
    'Airawati':
        'BBb21jRyq0yB7BiGtLyDrI3B9HjNlByN3P+V9LqFhR9DwHxElE5JuDxc6R1a4FnZoJ+EsJxJgH4ExD3Y4G5I6E+L8MqGmB6PgF5BpH8IwJ8IrM+UgI8H',
    'Gaumukhi':
        'BBS8umRi51yBlI5K6D1YgJiBkDjSoH9HmEsLwOsKoI7E+K+M8PpC0YiN1JskBjasWranMoGrQrFvS7TuJ',
    'Jhimaruk':
        'BBZ8umRi51yBxFzD7D+H7GpD3HwMhDzEtIgGnQ3Id7KkJ3PhG3C+DjL5F9GYvLkLtG7DlFwH1D1B1H2KByBzE4PsGwSuTjEoU/IhB5D2Y',
    'Mallarani':
        'BBcg/kRsj1yBhHcniB1ZoF7R/H7HqMxUtJnJqH1I/E0BvBnQ8FlHwHoDiGvIsF0D5JoSoJ5B8JiHvIqMqEmD0I7JwD2DtFsN7JsG2CuLjEqD0IgHvB+L0GI',
    'Mandavi':
        'BBTuskR8vxyBtIqCN6FvJtCtDkGxM7F5E9LnFuB/BxgB7H7J2Ozb2JSiLsNkD7VkY8IxLiOyT2kBrNyN5GR',
    'Naubahini':
        'BBYospRkl1yBzYhN7PqC9K9MlI+ExOtK/DpLpG6FrSrT1MpBkFlMwKtDpLpImU9mB0HiHoJpFqL8U2OfiN+YmKR0RqU0QmE0IyIxB0Y',
    'Pyuthan':
        'BBdmxmR8uxyBlU+mBqLqIvKuDrF8JpP6B2B2HvH2D8DmF7PyLoBlMzI/GkEpD1CtL8JrGuFrNvD1D9I8J9D1EmItL3JtGjJ6B6JnS5G9M6GS2QjP+SqO6JhHkRM',
    'Sarumarani':
        'BBY8whRo/zyBxQpQiGvNjIpLoF9FnF9L8C5OvRlM6BvIwGN0BrKsRjD+C+DgLhP8LmJ6IlCrBjK+J1D8H8JiE2gC/G3ErJyJnJ9E3FoZ',
    'Sworgadwari':
        'BBUismRw+wyBlPE5JiH1ChGxT1GxT1kByLhOjY7IgLvkB8OxPkQsEwR3K6CwK0QsL0HuUoBoPpEiBiQ0HxCgXnR2P',
  },
  'Ramechhap': {
    'Doramba':
        'BBO6k5Q0lw0B9OzE6OxfvBhf2PhIjEpe0VtG2LjN6E0NmVyR7EqZ/JoX9asc7XhG',
    'Gokulganga':
        'BBYmq9Q4830BlJlK7PB7F/P/cIpInWzRjLrD9QnItJxHAX3cpKnMhaxE7XzPqCrQuP5WiLiMscmKmTiV0Ty8B+xByf2G8Hf+O0Q6U',
    'Khandadevi':
        'BBU814Qghw0B5F/GvRuC6BrM5J9G/gBmfXpUjO5IwWrNrE/J6RjRiKhpBwT/a4C+IvKwfgNoPoGmEuChEyN4MgBoe',
    'Likhu':
        'BBPun4Qq600B/sBhY6K3LvFpLiJ5a5C5P8PrU8JsL8TwEsDyHxQ6VpCsQ8X0PoR2C5IyN',
    'Manthali':
        'BBb8z4Qs8x0BjU5EjKrLzPsUaqXnIwDpe5J9F/JoGZ3D5S2UpR7G1KnIzErD2DY5KrF4ClKhL4NpPjB7I6X+He2UghBlf6J+G5BsMwRtC4U0LjB6qB',
    'Ramechhap':
        'BBcu62Qoi00B9etF/byPtM3QxLtFuBtdlGhG6N/M8EtJzC7MoF3JmJnBlC3L2NxV0N8LsF3CX6KsD1DoI0E8G2KrU0QuDwThGQgBgFwPsL6bIhHqTwFqL',
    'Sunapati':
        'BBOmj5Qsiu0BhN9LtCiEnGlE/MvP4J9nBiJ8CuQpKgLsNgSiG4OzChLqNzVuGkEqe',
    'Umakunda':
        'BBiBun4Qq600BwqB7euO6OY4cyHAoIuJsD+Q0RkL+I4WscXqGuQuPLgU0O0IzKuYoHkDjHoO0F8L+S3O+W0BqlB1E+MvV9BrJwFjhBpUhTlB9MzHtB9HvVjNjChkB1OpN3J3U9c7P/CrKhf7c',
  },
  'Rasuwa': {
    'Aamachhodingmo':
        'BBV8voRyvh0B1T2R/doInH6WvW7V1FwFriBxnBxCpLwM1NsQuFwPrHsDhO+VsFiMxK6QuJizB3a3E6NoK8MpOsYxOqI6B6J',
    'Gosaikunda':
        'BB0B4zjRi8j0BsMzHgIlQyB3TnKzUmDvL1ErM4TvQmGkUiUiYmPyQqF5FwW8VoH5WgenI2T1RkKmqB1J+ElGqS0SwV2LkCmG0a7BqejPyiBrDoY1diF6cwgBiJpEiTuHT6MmWtBoCwR9H4H1I3CjZ6KvRxClhB8JvSmRvGoOtFLtJrMFnlBvHpEpGplBlO7PgS/P7C/KgJrRHvO/R1axUV5Jtb',
    'Kalika':
        'BBP+9jRgkh0BvP/M3R2DrJ5HYwM/IrByBnd+OzC8CkJiGlChDkHmF+HyI/Vkb2JsH2L',
    'Naukunda':
        'BBQ4zjRi8j0BvRphBlNpHxDnZnLvI6E1TsJUrB1L0J4HgMnFqK2DsPuU9CqOoK0UxB+T/HgQ',
    'Uttargaya':
        'BBX61kRi9g0BlPzXvI4B9OhJxIgWlF9H+CrH9FuC7CjJ9O0CtB9I6cmCoFlb0G1G6buXkC3ZmMnD8HuQkO6CiO2MgDqXrSgLrQtF',
  },
  'Rautahat': {
    'Boudhimai': 'BBNy/sQwqh0B4ClOnHpDhF9NqD5XuMnI6BmHqJwBjOyNoSiHqFqazIN7QmN',
    'Brindaban':
        'BBZ4qxQ4+k0B1JvL/Lc7gBpc1JkB1NhLT/JkNtJpHzCalOrJtEkO7R8G8CnBuJyFFgJqOJmWkM6QsFjGmIuFkFlIiG0HQzK4J+C4JwtB',
    'Chandrapur':
        'BBiB4qxQ4+k0ByJtF3JvtB3J9CP0KhGzHjFmIlItFrFkGjM5QUrVuV4BhCxK2RRkDzIsM7FkHmHwKjHqP6J6M5B2FnHoG4G4Q2ClFgejH8GHkVvIqDnG6evLgDzDuK6HkUnHsB1BtH1NtC',
    'Dewahi Gonahi':
        'BBQ+quQy3h0BhQ2Cc1I1NvDpN6InE9FiDtGoB8E8QlN0IO4BhNgLmEiGjGyNuP5FsKjK+B',
    'Durga Bhagawati': 'BBLgxsQq7i0BnJkG7D/J7UpM0D7EyN6C+BjK+K7CkFsF7BuJmHgB',
    'Gadhimai': 'BBM42tQg3j0B/M3JW/O4H3KkOoBBqHiPpIoGmCXkS2V8QzI2GnTB',
    'Garuda':
        'BBQu9uQkrj0BjJ3DoBvRnGjChPqIxGvPjJZrDzOksBlF2BjGmLuD5MuQuJ+DZmOqH0CjNuJ',
    'Gaur': 'BBI0trQq5h0BvOwNjF5NlJxC+BxQkNxGoKkF8F8F',
    'Gujara':
        'BBYi7zQ+gi0B3Q1CnG3G1FoH5M6BpP5JvKkHjHlHrM8FjD0I1RSiCyKrTEpV9ckPlO4MAyCrF1EnCiJtNwRkEkXtO0KyPyPwJonBmK',
    'Ishanath':
        'BBPkksQ2qg0B/PmMrM/CfgGxHyB4B0ElO6FgBvcwHlJ8MpCwDpI8L9BsE6EhD2MiPgC',
    'Katahariya':
        'BBS6ovQwzh0B5N1BhB+F5OQL7IkK9B6FrKxNtPqO9FyL+KQhI8GnC8L6LsR7JhJuN2EoCxCsF3MA',
    'Madhav Narayan':
        'BBO86tQo6h0BZoE7MrBsD0OgLyEjR+NVgPgN4JvUwDnSnjB2LlLiBrWgSxHgNuD',
    'Maulapur':
        'BBOu6uQ6tg0BjT+LnLlEnDgG5DnTnShH2TlRmK2EmFvJuCmHgJxCrI8PwH6KuJ1C',
    'Paroha': 'BBMy/sQwqh0BjDoOjH6C/KnNgCjHjKrR4FzOjPhCiD1M8b+ElC+S4MgM',
    'Phatuwa Bijayapur':
        'BBW0rwQowg0BrR8JtHrK/JV/DwJ/K1QtJ2CvH5K0HvPiMOoCtF+Q0O8GzC2DgJmIvMgB0OiHxCNrIgK8KyXzCyIoGjXuO',
    'Rajdevi': 'BBN63rQkni0BlGRnKmTzH1GjBiK5HwDzBrL3JrEsFtamJyCqF8NqJhMgNB',
    'Rajpur': 'BBMqqsQquh0B7KkMhH1E3KyDqCpP3QxOyHxBgB/FsMgDgQlM9BkLkKsR',
    'Yamunamai': 'BBNw3sQ8ri0BlHf8BtJjFrF9K8C9BkK/IiBpEtQwF9DiH2EmPnMqByIyOmJ',
  },
  'Rolpa': {
    'Gangadev':
        'BBQ+htRyzqyBzSiK9jBzJT5KjRyGBtMrLWtP7JwGnIoC7UudvPiE8PmL3B0H0NiLoG0f8H',
    'Lungri':
        'BBPs+oRinzyB7LzK7MhC3J/VvOkBpL7UnJqFzHhHwBzL2W7B4J9KoD7as/BsnB3XmQ2L2U',
    'Madi':
        'BBR0rrRohtyB37BtgBgDrtBkJ/cmSyNsLVCuMkRxGS4KmUuI1JkajZ/HpE2EkNkK+FkSvJuDgFO',
    'Paribartan':
        'BBXsxsRsiuyB3O1Q5PuJ5EwNjJwFhB9W0IzWvK1NwJzDjGpS/MvJsE9EkZgImDvSyIrJ8NgDwShK0LyS8HN0DuWxUwK1LghBwC8J',
    'Rolpa':
        'CBVs9vRsrryB/Q3J9JgUwB8SrFrBlFuJwCoLzVrCqBxN/SjcyBpIuPvNpBtb4FoD+JpGE3HwFMqCtcyUoPhE6RgTkSBMtgHsoEnJ6ElDvP0ExD3I9HkM1P3JpM4JjFoVyQ1PsQf+EqM2E',
    'Runtigadhi':
        'BBY8+nR4osyBhGyCnJmd1GIpBgMlJhC9R+JlY9axN+LjQrE0N1UgNpG3CpLoL9VjMjM2IpD+CpasMnZsgBoG8FgNqK6F7WgrB+SwH2IvG',
    'Sunchhahari':
        'BBZs+oRinzyBqLnf1L1U4XlQplB9U2BjRgPxH8IwDgLjJoO4B2FtF6T8E6QrGqHwLzjB21B4f2b0VsJb6G9OsEtLwRvTgB5CqR1UmItKrS7QpE',
    'Sunil Smriti':
        'BBemvoRmswyB5YzQQ6RhIkOtF8FxYmEzF9HoB5RoR1PyC/WhQzHqEhB5HjdgDpHsH2BsJpHiKuE8DuMwDtG+HmLoCwV2MyJa4P8GpLpBhT6PnFgdoXyF5CkGoF/0B2P',
    'Thabang':
        'BBTonsRqxyyBnW9J3f1b4jB71BnL7MlFvauJ5F6EvN6PtJ4O2QpB0KqTuSpC0E/E5C7BqI+KiUpN6K9C4X9Nsa',
    'Tribeni':
        'BBSi/pRw2pyBpIyHvG8hCzKvHtD0UrN2GF0KlQLnJxuB/IkG9SvHub35BqmBnX4C7H6MJqHmK2NsCL2Q',
  },
  'Rukum East': {
    'Bhoome':
        'BBdg2vRwquyBlR+EpEkTlJwD1EyLhKmCiEwLpXidlXg6BjXwVAxxB8Nja+C3XoNxJ7KpV8BpIgF6CqCzErTzS2UtmCoU1JmHoDnGyjBsO0GpBwQqWwFwJtL8BkMkOuD',
    'Putha Uttanganga':
        'BBoB2yyRmwwyB/R8LtHxKxPTlKwRpLnBnCoT4NkJxHuRwMyGkEkU5PmHvI+W1J4F9FhH3KF/K0QnZvRjKiG7GwO7RpHyPjhB/YvEpH7LRtTkO9e4IjHanLqXhdhEvLiKlC2ExLmJvD4EvT4QxEmLyKiB2P0J4GumB5TgI6V',
    'Sisne':
        'BBoBs1yR0wwyBhbjjB/H5V7mB4ThKlIkCvH9D3JnHpCtBpLnOxD7BjMvJuLzW9F0BhQrOzGgHxb2G+DrCoJmF4HyQBxBnMmFtJsFsBvB7S+J/TgR4J5OqhB8MkP4CwM8JkBiDwJmhBhJUjW+OxC6ZkkB+K3DsZiTnJ4P2HuQ3L6c',
  },
  'Rukum West': {
    'Aathabisakot':
        'BBrB+sxR4zsyBsBt3BmVhT5D1G1BiGrJxD7FtT5K1FQjSvItP8DrM/I/J+D/J/IhJgDvCqNmIqWvDqO6GqEynBof2a8FiT6NwPnD4JwGgQkK2GwQ9B6FqHkM3B6ToSwGmUnSipBKiQ5c2MvFoIxMvFnEyFxKxCxH5NsKzP7J1L3QjK9K4D1ZjkB',
    'Banphikot':
        'BBS+sxR4zsyBTkWlhBiJ/aviBC/M8QziB1B/V7RzRuHrBqFlMuO+K+U5KsN0C0J2WsJyD2BhGqDgF1U4U',
    'Chaurjahari':
        'BBOs3uRmvoyBnRdgLvdxCtU8S72BilBsHhE0H6JyPhMqX4C0EnToatJhFwBsEhJsC',
    'Musikot':
        'CBVs9vRsrryB/Q3J9JgUwB8SrFrBlFuJwCoLzVrCqBxN/SjcyBpIuPvNpBtb4FoD+JpGE3HwFMqCtcyUoPhE6RgTkSBMtgHsoEnJ6ElDvP0ExD3I9HkM1P3JpM4JjFoVyQ1PsQf+EqM2E',
    'Sanibheri':
        'BBX+jxR+rpyBnb0KpO9KtFmMtHsB+CpSzJtFPrG3P7FkIpZiJrCvBrEuJiFoTna3CzE0LjZuNuK1MkSmOmL9DiKgJgK7DsMwIuP',
    'Tribeni':
        'BBPk2tRunryB3JtC1KhSiJ/lB/DzKqX9FoHjOiSewEuIpCucvFLD4H9JqGpF/Dawc',
  },
  'Rupandehi': {
    'Butwal':
        'BBU4w9Qy2+yBjUmHpMpFlEuDR3flNQzSxLuI5HgIaoBxMiJyGzEpe4GGsL8OmP1EgM2IkPnEhIoM8CoQxJ8G',
    'Devdaha':
        'BBW6j6Q+zgzBoE1VxNsB0EpR4TMa6I8LuEwQlGoGqEkPlME7IyKxMiJ2FsX5HI2Y/OwwBxIgIiDkH5R9B3f3jBtY+EpByJ',
    'Gaidahawa':
        'BBXq+7Qkv7yBlLPrEmHpP/Hvd4BkErJ9L1B8E9drKpFkJnEnMzLuX1OyiB0QcyIlU/B5C+H+SoDZyMqKjGtMkbiEnGiXrBiC0P',
    'Kanchan':
        'BBSw/7Q2i7yBtElF3R+C7DqGsMnbpKkGaxMhSpB+B7JwQyDsC7KwT1FgdmEsDuUhY3Df8E2HKgI2J',
    'Kotahimai':
        'BBT624Qi28yBxFD5C2I3KrCvEtJzQiGY1RhInNoRvHxB3UgN/C6EgJuTyKSiL1GuIvE7MlIkBqH8V4I6F',
    'Lumbini Sanskritik':
        'BCXm65Qgl7yBxHdX4HnEzCxFiInH/LrKuFvS/P/MgD5BzH/Mc1GlT4OhZiI8IyI/IsPyG4GnFgR+HyNhCoIoL1HMX2H4J4BFvfgO2HDF9JhbHM8J',
    'Marchawari':
        'BBRk91Qg66yB6CmIoIrDmMsE+E8W+HoJ4J3DgCsWkGwE3EuIrPpP/IiC3DrI1Q1JvGxN6CnMvEH',
    'Mayadevi':
        'BBeuu6Qo07yB/P+LYyG0HuCrHgEWyHrSjGiKmamB8WlEH1JnNgHxHtLxPzHlD1IqJiDvP3I5F/GpXiIQqE2M2GzIjC/TmGEoHgMyFhIoE0C2C3IgRyCzD+JyF/B',
    'Om Satiya':
        'BBW8j6Qus/yBnJuKD4IyNrBvGwZ/NzM0EzPrGO2BzKzJvTpGiB5C1PwB/H8FPqSsQsB7FzIxJ6H1RqE8J6JhB2E8F9IwM',
    'Rohini':
        'BBO+35QwygzBpIuG/KnDtHiL1MuC4Dj0CsKhKmGoMnB0NqGhB0JwT1B0KsGNzEyP',
    'Sainamaina':
        'BBVq+9Qy08yBjPoE/L1IlP2ElNrPvIpWoEPhD9LiWhS/H1J1HJgB7EiY4DhCjVmlBzJgGsJxH6MgKgG7GyFiH+nBnUwa',
    'Sammarimai':
        'BBO8m3Q2+7yBxEmFvI3IChL5JrQ3PyC7DxEkLnQ+HrEqLkE0GtJ6FyS2PyB0CmV',
    'Siddharthanagar': 'BBL+i5Q+o+yBpE9DrKiKkC7tB2IpJiT4S1GkJyJgK5B8JsHqPtSnQ',
    'Siyari':
        'BBVk/6Qkr9yBxQvFxLkKiL4BpC4G6FgIjF2D3UnN7DvhBhGxGsSkGVxHsH/DzHtCXxGqP/LsH2FyBmL8IgBwI0QqJiD',
    'Suddhodhan':
        'BBTmn8Q+l8yBhG4BsFschJxGnByMtR4GzL1F4DlI6HqCwG9L/EnDQ2F9GlQhPvGnHtUgQ5CwPgIwD5GkKzB',
    'Tilottama':
        'BBT6r8Q27+yBrGmSjPmMnGpEvQmG7LtEZ5IrJrD1FgFiBlf2M7Q5F/HqC3GhL3B2LhKqZ6HsWkPmNPkE8Z',
  },
  'Salyan': {
    'Bagachour':
        'BBV+krRwtoyB+D/TtDxD/E0F1C/FY/KnG1F+DjL0F1D2EyJmStYoQnB6a2kB/F4QsQgjB/IiJ0FwFhD4JlrB9MpIjOtLwB',
    'Banagad Kupinde':
        'BBoBq/uR42jyBzd0B1EmItIXjGwM9IAjUrT/OiB3KxI3EuS1EpF1I8H/BlI/H2FmCrKzFrI+EhI1PjQvQ1ClEjSlH1CYhQqU1O2M8I2F5J+QxIqMsB3C4OgFxBkI2QuToJybvE4Q9OgQ8KiLzED+M2Q6BgDqRhGTtKuR',
    'Chhatreshwori':
        'BBe+krRwtoyBrIoBxE4HpJnB7KwM1ZhMpE/MhJkC6QpOEvIjNjV6HzP5LxFxIsIlFnK8FnfgG2EyI7JqM8D4HsSrK2I8ImF2H1D6QqWgNiEhD2GoG2F0B6QqFtFuDyD',
    'Darma': 'BBJkutRs+oyBrQ/iBgG7Q9HxE3F/T8bB8e6O3E2mB/NgV',
    'Dhorchaur':
        'BBQultR6rkyBlbkbNoejRgClSuYtFhMkI5KnF3SiH3BzC7NmJ3EmLxS5JpHqCjWkNsIuQJ',
    'Kalimati':
        'BBlBw6nRyjkyBqDpR5NpU4B3KhY5RtIkEzDjHlTzG8a/bwJtWgLhDoKrYhD3NmHwC6NlN+GtW7FjJiNxDkPvbgpB4P6E6P7Gwb1a+3BsP0hB5N4O6B4OkGiCvK4NpBuamGoL1GAjFmMjFPyC2JzEwBrGhFrPiF',
    'Kapurkot':
        'BBWu2nRyjnyBiTuJsHsRuL7EuGmKvH6EuE8EuDlFqFsC8B2MxGhC3C8HhhBkR3JkVrKhG7F/MrgBnG4MvCMhQiVtSFzPgOpH',
    'Kumakh Malika':
        'BBRuwuR8/myBve/NpS8CpSlF1E/GkFlbvDtG2a7a6LAgEvMqgB7LoKiDqE2R1G6C7C2OgHsWxJ8L',
    'Sharada':
        'BBgB6hrRi2myBrGuIrM/DtRzWzMsClEtFwKlH3HrSpM7DzB5cmGlBiFpMyGQnGvLsBxa4JrHqFiL2P6B2PkQ9EiI0FsInCsKiI1FmEqI0G/HsHqP2GnD5KgXlJ4E0C8NjHqCoF0S',
    'Tribeni':
        'BBW4ipR2joyBxGnKpL+ErHrRhTtJ3FhZsHrQlE9LsFnS/IhQoKtJiQ4N8P9E8J6JtDsUxPgC3CgbuF0LyIrI8L2F7HwPiNud',
  },
  'Sankhuwasabha': {
    'Bhotkhola':
        'BBtB0i8Q2zt1ByH7L0Q2B5BzkBhJvT3X3V7CtWuZtmB6PvFoSoNwiBrXoC7X6WnkBfihBqMkImHyN1EgbhL+IqB6Y+KkK2KgcxMoIlFzRpH8ciPmZhC2c+O8P7I0PpU+BjG4N8OmPU6UzQ1C5L6HzRxMjHiEhMhOhNjBkB9KxXrKwElJnD3G0KnD2D7H3YpK',
    'Chainapur':
        'BBT000Q87s1BkT7mB/B7YvH1ZzU1ctItYjSrR4VnWwLvDoB4HkRGqGqJM+jBwQ2uB8TyP4Q0fsKwHz5BmhBlH4L',
    'Chichila':
        'BBP0q5Qsgp1B1VK/RnJtGtboH1IvBzPiI1GyCtboMiMuEqPuQ0EmFsNeoM/I2C7DqJ',
    'Dharmadevi':
        'BBQ2x0Q6yp1B/WggB/Tg6BrLvLnC7TzM1IlMQqTrU+HgB6G3LpF7b8E9Q9H3PkVzNuEyC2N6O',
    'Khandabari':
        'BBR6+3Qklo1BnU6C7LnO3RkElS9YhNuHtZhE+TxDsI7L2WqG2anmB6TtEqW6S3B4V/IkLuCmLnH2I',
    'Madi': 'BBJ000Q87s1B3gBzQ7KB2C9VkM/R8CtQgX/fyM0PwJ0uB',
    'Makalu':
        'BBxBss/Qgzm1B5WokBnC8XviBsXnSnN5PwFtZumB8CuWueuiBmEurBzQ1BpIwQpIoDxDrGvXxD8CjK7TrT9MsD9VpH9GrlD0H7G/Djd2NtOlJvYkFzPuK5BsKiNsP9RqIdqXrdmV/I2bjX8J3M0DvY6M/L2ZyC0O+Q+G9UmN2I6iB1O4K4IwSsBkFoUxE0O7O+I5GyPzUyG5EwLzVuF',
    'Panchakhapan':
        'BBMyo3Q67r1BhKxG3Qzf7TxPvQ1uB/DzuBqIyD0P3FwXkkBgXyUpImK7DkmB',
    'Sabhapokhari':
        'BBPop5Qits1Bh0B9IpMrHnJltB8DjmBqIlK/S7P5KxS2QjD8LoOoU5C0FiUwQwH2VJ9GuK',
    'Silichong':
        'BBe6r5Q8/m1B5KA3MlYvR/IiK9TjF5I6C9N7LtJqEnJrH/TuO1rBmPmOiQvM2LmDyI2LuMP6G3HmUEga4SwZqCqYgNnBoSxKsN/awWlVgJ1U4a9KyDrP+RtNpNrHiC',
  },
  'Saptari': {
    'Agnisair Krishna Sabaran':
        'BBQu3pQw7/0BxP3ClCmI/FlHnHkJ/RgClM1M7WrCnBzK+H1GtE3TgiBtEkT4DuUzKnIoHwQqd',
    'Balan-Bihul': 'BBI8tnQ2m60BvRUnGgH1N3DoJ7kByfyQmJpBd2P',
    'Belhi Chapena': 'BBMo3mQ6t90B1KQ3GjN5W4DpHiM9UvImLrqBmNsFkK+MyZmFpDgOkP4B',
    'Bishnupur': 'BBLutlQ8t+0BqK9LlRzFqInXiX7D0GkN2KPU6UhbjO+IqV7N6I',
    'BodeBarsain':
        'BBNi+mQky70BkBrG5G5CtXsBclH9K/G3HoDmB9EkY7P2N4D+JjIqWH+ByoB',
    'Chhinnamasta': 'BBMutlQ8t+0B1YkG1K7MlE4B5D5K4H/FyB1MiQ5BmFoHgIHhC4LmRuF',
    'Dakneshwori':
        'BBO+jnQ4j90BpYBmDhOxZlFpR7O2MnkBiNoCoD4K4HwCuWjBnC0P3LsC7C8K8XkM',
    'Hanumannagar Kankalini':
        'BBWoknQ8mh1BtFqDOyVpOsC+D4TrNxYhU1KxJpPjPoB3CtUxLnR4JnhB+K8J0BqN5E+EyJmPsFe8F7N+H+CgB4HoemFyNuW',
    'Kanchanrup':
        'BBXo3pQk2g1B3O4EpGyKlBwiB9WzBnWjSnWsrB3HtJ7E/TwO3CB5W0Q9CuJ7L9DnEqQ7Q0S3BoHjJgGmHmClIyP4C9BkG7L0CqG6O',
    'Khadak':
        'BBRmqpQsw80B7MF7drP3RqHd7EnH0CzLhIuJxOgVXlErS+DlT2S0JkQU+SmU0B6G5GwF+FuO',
    'Mahadewa': 'BBIsjnQ61/0B9J+SpJsCnRvG4GhgBqe/E0EuHtGmE',
    'Rajbiraj':
        'BBQynnQ8k/0BnF/F5JK5d6Ic6GxOV1FvPiDxQwNyE8N5I9IpVsVgP0IxJsKgPxEgIuJqF',
    'Rupani':
        'BBRowpQqm+0BvV4JjT3D/mB0EyE/HhExL1I9BhChL4I9OmJuJyTCXyIkLN2CwPyX6EyUjL+BmH',
    'Saptakoshi':
        'BBP81pQk9i1BpaxVyFIiErThH3FiEnJqGxK2M9E8BmJiRkQuMpByEiIlQ6GpFmKmCuL',
    'Shambhunath':
        'BBUy1pQ2890BxLsBvJqJzX7EzCtPpLMevIxVpBF9UrWvIqBrOuUiIoHzCkB8EyRpH8dsPsOa0GyEnKyM+LqN',
    'Surunga':
        'BBV6tpQsn70B9SlUzVxC7O1KlHyCuE3F8F8Be1PyarHwZoH0P1EqNmQ+JlF0PqDpCmO4F6JpG2BkCiH9XvPhEgN3KjB',
    'Tilathi Koiladi':
        'BBP8+lQ0kg1B5MxIlF6NvFhBtJhP6E9EzBpN9K7J8ChL2RlCtDoO2FwPyOWhB1GwI1D',
    'Tirahut': 'BBLoknQ8mh1BoDxE/J5SvKjEuGzCyIxToYgDkL+N7PsPoB2JpP8K',
  },
  'Sarlahi': {
    'Bagmati':
        'BBRkjyQ4wm0BxVNzGzJrB8HrbpEM5G1JzG6CpHxN5F4J7QhQxB0Q3c0U0T6NM+e0hB6Ja5GgH',
    'Balara':
        'BBRqnrQ6ik0B7RpTyBvIvN9Q+BlF4JsEcqLyItDkBhKiGmH0KhM8PqHlH8LHsT+J6TtNwGrChS',
    'Barahathawa':
        'BBY8gwQ68l0B9WzFlCyJ2G4HlIrEnC+D2JkEnCwGtJjM1S1JjH4FjJ/DiIjL3IlFoEhHxGvHsTphBuSmBwOrJiQoKzQ4ciQyB3J8QyN6F',
    'Basbariya': 'BBMiguQi8l0B1H3CDtJjNyDiL9SrD3PqFraqWkJtSwgB0GoHnEiH4ImF',
    'Bishnu': 'BBLu2rQs9l0BnKtCqDhKlGrB7G9O2EvLgP+FeyJ0QE6KsLzR+P',
    'Brahmapuri': 'BBKk+tQ++o0B1RdiB5L/ThK/NrVgoBxFWmL1K2FsLmU0KiG',
    'Chakraghatta': 'BBKi/tQ0+l0B9KqI0FiI/E0JjQfDnL7IlEyDxWiZ3BEuJ',
    'Chandranagar': 'BBMg7tQgyo0BjGIrLlU+KtG7CpS0J6DiFtF8QewK8OtH2PuH6KvWyH',
    'Dhanakaul': 'BBKkwtQ4jl0BvTjG5JjOK3V1HrMuGpS+OweiXlDhFsasD4P',
    'Godaita': 'BBNkrtQuzl0BlbpEnItKzQDdxJzQ1JsD9RqKnC+B8RyR7FgRkI+EsMwTkG',
    'Haripur':
        'BBU8jwQstn0B6B2L5SvEtLsHpSvSyCnSyGoFyG5O4G6EkCnG1JjEoC9DmIsE1G3HmCxJ4V8E8KsHL6GsJcnPiJ',
    'Haripurwa': 'BBLutuQqpq0BrUpL9JyC9ThNH5HwR1NwRMgGmInL6I4P0JqDtE',
    'Hariwan':
        'BBP6jyQ81o0B9FsDzItH1S9BxKrlB9GnFlNkI2Bzb4P5HwQyEkB5H0G0Jga8C7G4WqEgG',
    'Ishworpur':
        'BBVutuQqpq0B1B3UpDuE3PzJqL9I1JxSqhB7FtH5KuH1P6XkOiCwT4Rkd4K4jBipB4YqKZuKgV/OlOza2CrB7GxMvDzX3U',
    'Kabilashi':
        'BBRq0uQ6mn0BhUjDhFuFtInEoB8IzKcxBrY+MsCgFzJ5FzGyD3G2QgBkH3F2S2J6CiHrG2O3GjF',
    'Kaudena': 'BBIs4rQkjm0B9B3FuK0CsWlT+H6ExDyW8ImEEoL',
    'Lalbandi':
        'BBRkwyQmgs0B3KnSpKa7pB9ZajIrlB9xCoGlG6SwE5B1LkIpHgMuEyKslB2S+B0IuH+FrDwb0jB0FwQ',
    'Malangawa': 'BBJumtQqrn0B1T4FuBvE1Q1NwCvG9OvOqB3G2kBqT4KF',
    'Parsa': 'BBIustQg+o0BtRoS1EzEnNyCoG1X8L/E1BrJgUiK',
    'Ramnagar': 'BBJ6ysQuvk0B/P7G9IzPXxXmH7LuH+LyJjG7FiS2HsM',
  },
  'Sindhuli': {
    'Dudhouli':
        'BBiBivxQw110BjGuK0EqLjEoNjVlKvH4KpKqC/D4JppBhSflY9I1T5S7OsI1CofrqB6V92Be1e+GiDoF+NuVvT8D4IwJXToIwFgD5CuHrJsCzDyc3HuFRuOlKoMgH0R8SxGoJgRgOoBMggB',
    'Ghyanglekha':
        'BBW8j3Quor0BpV6lBlJ8BkE6M5Qud5BxTtOqI5MhInCpVoO/H+BlKpH9FiDvN+G/EuGnfoIhD7JrQsKhEsHyMkR3E2U8K8DuI',
    'Golanjor':
        'BBa0o0Qgnz0BvR2O5EjM/SxRoKvO7K7b+G3BqD9OiKvJ0J9YrC/N0KgG2HrE2GxU6S+KakI0HnR2PwYhSyPhNmVmC4LlJoBjFsJuCuN/S4XuG8D',
    'Hariharpurgaghi':
        'BBiBki2Qs7n0BhhC0BpFkN0C4MtPzH7QoMpM5HnN2DQtnBpE/FsHvVpFrFiCjR6G/GkF6I6GJrBnI6F7F+DwHkHrCPuNgP5DRlKge5EyM9d8WzHgHuQgJsB8PmY7GoOjF9DpE0G+D6L5KmQ',
    'Kamalamai':
        'BBnB611Q26t0BnJgTuDmHrHwWrV5R1GyU1HsEzK/FuBgS/UqoBxI7J9CjWrV5RrXsU/I7K9BkQ9QmHxP6QnF9N7G7C8E1mBmhB7Q0HlLuS5DwPriB/L5MuM3QgJsD6EnewUqHiWtIiO+HkGvG8R6EoCmQrOoIsCiV6MiIuOpI',
    'Marin':
        'BBai+1Q2yp0BhN+B+JmQnIiDtQ4xB3O7EjGwGhO9H9VuI/PnCzEhFoQjrB9G/RxZ9foN1DqM6H8QnMuP0HzC3MkFhNmU5BoH2EmkBtFwHwXvM0J6G6N',
    'Phikkal':
        'BBVivxQw110B2K9K4CxW0FiCkQ5O4B7R6N6H2C/KyV6DyO/OnJ6e6O0WlO8R7F6cpQ0BtG0W9HqGrU/J/E9IgFrK1WvK',
    'Sunkoshi':
        'BBOg91Qwrv0BvOjQ9B1N6a9qB/BzSmJ7BqV5lBgZ+HgIiWlQmThKipB5RkRiF4InLqL',
    'Tinpatan':
        'BBeszzQkzz0B7Od5CgL1N5H3B8RlRgPxHhMpUrHpC1KvTsG3GhT+J5KStO4HtF0DxcsMlIhF7M1JK+JrdsIqLsXrUsV6R+CkWyI8J/H6GqC+OwHiBiB8LnKwOgTyR',
  },
  'Sindhupalchok': {
    'Bahrabise':
        'BBWwx/Q23v0BvM2KjQ0DqFvchHhLlBzrB/IrIhC7NkjBxSicuL2BzIgKwBkLhIiMuF7E2MtP8E/M2VpMD9J4RhKlCgC0RsGoE',
    'Balephi': 'BBJsn/Q4rs0B/fkQqBsN5S98BkiBjLidoGW2SvR9I/CuS',
    'Bhotekoshi':
        'BBWwx/Q23v0B5BtfrGnE/BzR2JuCqK/RqMEgN1VuP7E8E1M0PiXqMXkciMkFtEmMmMuF9D2FwGvjBqvB5iB1RxSsgBsCoIxJggB',
    'Chautara Sangachowkgadhi':
        'BBPgw/Qsmr0B/XlFxW6J9SO1axd5K9D3DjMlJO6nB7V0YgFwkB7FkNsGmPrB4HsIrQmR',
    'Helambu':
        'BBWy7gR0xn0BtQvUnH1rB8U3CwRiHsY1F6HsI8M9CyXmGqQzLuQ9W+NsTSoKyUWsIkIqD2OxQwVh1CqEzWqN6B4OzFwB5Y1S',
    'Indrawoti':
        'BBPilgR80p0B3HrIlPsBtLlGlmB2FzY/EoJlKoI7Zye1Y2IYsE4XoM5G4PsdawMyJoF',
    'Jugal':
        'BBrBu9jRs4t0B1FvGtF+DlMlMjFuEjchMpMY7HjQ5TrMjLiI/JvB1B0I1e1JjGjIsDpT8SgIDtMrHvFmH5kB+R1N0HwIoScoNyN4PnC0EkFmF/HyL+LyX7Doc7RsKbyK0IoHtJ2Y5KuDqTqH6DGolBkSiXtLoIRoMzK4BnO+M7MlBlJwR',
    'Lisankhu Pakhar':
        'BBN6j9Qouu0BxW4BxDjNvQ3EvQ9PuLpL5BvP2MvQkXqB0JsV+S0BoJ0JrWmT',
    'Melamchi':
        'BBUg9/Q26o0BhR5e5KuIvE9X1IX9U0S7C/EmD/Z4EvClB6I+FgBkRjU1I5lB6YnPwU2B2Y4PxVqEuJgqBuQwUvVuR',
    'Panchpokhari Thangpal':
        'BBkBi+lRsvp0B1Y6KnHuJxKzIrKcnc8RxX8DxL9LlFgIzEjF3MmDnQvO1SjB7M7VzFejBzKsJvZwVtR+JqBgTgRuKWZnP0WpNwOyBoLhGkL4F6G/G2F2F6clC2N7E4J1SgH+MtJ6WgD2KjSqQ+NqP',
    'Sunkoshi': 'BBKkj+Qg/s0B3HkG1I9JzSrB3H1TjLnF2DzyB0dmdsHcuNogB',
    'Tripurasundari':
        'BBN80+Qgmw0BhHzD9J+I1K5DyDzOjGjRoEjKhXrP4BnWkd/YoP6TmB0rBiHiL',
  },
  'Siraha': {
    'Arnama': 'BBKu4pQ++10BrM3ERrHnS1CxJtPrIduCxGqpBqEwU+KwEsU',
    'Aurahi': 'BBIy8oQ4t20B/VzDpJ5HtCtpB+SsG0PgRhIwS2QuJ',
    'Bariyarpatti':
        'BBP47oQ2j30B3JvF1EsOtM7DoCsRhIrL1KxE1DiEkIjjB2GuC4BlLqJ6HyUwBC+I5DxB',
    'Bhagawanpur': 'BBJ4snQ+x50BhbnMwO5iBmO2FgB+HsJsDEgMiFc/C4M',
    'Bishnupur': 'BBG2uqQiw00BlEgezZ9UgI1K6CjV0S2M',
    'Dhangadhimai':
        'BBXyzsQoq50B/JvK1f7L4C/EnJrIsD/E5HvEvStBzFgKzQjIgLhsBqM9H6boI2H8G/EwNkIlC2LwQqhBnFoGpF/B3JuMoFtMu8B7KG',
    'Golbazar':
        'BBX2nqQkv20BtOtR4SZK5GlFrBsDzGoa4H0CrF4PqId/NrH3GsHnE4YimB+Q2FvEoPgKqFgC4J1nByKxLvQjImCgFvNvH3GlbrI',
    'Kalyanpur':
        'BBTs2rQ4nz0B/OxD7G2F0P6KjH8FoEsEtL2ZjTxILhKzS1MuB8H9E1DhD+OlHnHLlUogB9NgChJ4LzHyagD',
    'Karjanha': 'BBN+1sQsw00B5QjDsFzK7CrKkG9ErXxLHrS+T0BgMzJ6fxE2MsPpKVvL4N',
    'Lahan':
        'BBXg0oQmu50BfzRuFtKuNqBqCpElE7LyS7F0QmIwF/J8Y+EH4LuHgD7C0E2f8LgKwKvKsPpHkBR8V7JV9V9S9VqD/MjQ9P0E',
    'Laxmipur Patari':
        'BBNm2pQu930B5SwGwCwPtNpBlKjX1KLxEtN8BvE0M4D0EnOgV0I0K4MiIpB',
    'Mirchaiya':
        'BBQ8/sQwr20B7LnBvczpBlIctM9JsKzYnErEkH7F9PrJ2D5F8pB6NjG+E8CsKrF0K6QkD6LwP',
    'Naraha': 'BBFwqqQiu10B6Ctb4KrBoXoQuI6V',
    'Nawarajpur': 'BBJq+nQ4l50BhHlJwB1IxY/QyH/VuI3CsTwQvF2R8O6H',
    'Sakhuwa Nankarkatti':
        'BBMg0oQmu50BrU8H7SjEmOtER/GuLlMsFuBsB1IlPvI6JrRiH6BiK6T',
    'Siraha':
        'BBQizpQw900BnpBpEvCyGhcnX0BxXyN1D9D1b2KwFuH1CgBsJiIyC6JgR2TzCnBwW+KoJxHuG',
    'Sukhipur':
        'BBO2nqQkv20BlH8DhHifzHwB1K3MlLvCxExRyO3H/RrNgFIiG7OkM0DeyH4UqH',
  },
  'Solukhumbu': {
    'Khumbu Pasanglhamu':
        'BB8BiwgRw2i1BnHre+CnJhM1Q5pBoKzCpGtHsBpH9MxL5C5G9T/O1IlzBnJ/LjLwIpR3XrEhEjGoFzO0DmI4IlCxE1GkEvKwKzEocoGiL7P2QpHgChYmdzSlBrPqF1F8ZUwH5Q2Z2I4fMkOpEwItR8jBhDue+MMoIsLoKyFlEmViGlGsVlQ2DpDwQ4X+hBhD4enS0Q/OnL9H4DE4M/LwKlCyc2HkKvB0J1RiO1FmW5PiFlIkfvSrBlIvI',
    'Likhu Pike':
        'BBOyq7Q6p50BhPuLnM7K5KyD/ctc3DvLhJ4CiBpKuSvNTpQuGrMka+M2LoX2OqN',
    'Mahakulung':
        'BBoBw63Qkog1BkflKsD4IkH1KvGhO6Q7G8TE+M6HoPzBgJ/J+OoNmzBkJ2MiKkDwQiLoCqH+MuHrB0CqG6pBnKiM2Q9CoJoHsexU4KpM5I9G+UzO9Q1ZxClPoSpY/MvZpC/Z3SlUD5G4HtMQxI1L1LlDhQwMnFpJ9U3KrIllB',
    'Mapya Dudhkoshi':
        'BBS+j7Q4i/0BrzB9SpdtVyKhUnUjVsGzfo5BgO8D4dgOZoRgM9LkGzCyKwEkF3ImCzDlInF0OiEkG4XsE',
    'Necha Salyan':
        'BBN633Qgz70BVmFjR6F1S4PhE+QnHRzIpNUh2BwP/DsOhSqG6PgIjHsWsF',
    'Solu Dudhkunda':
        'BBfqs7Qwo90BnR/L/Na7D3dnU3BtZ7MpbuFrIrD4KngBrWrF/HkHpG5P4XxVpDnRwEvF2K4ByFhI0chM4DwLgduc6KxDoM8KiPtLsjBucmTqBsesOsEsWxdmT/BiY1QqHhL8P',
    'Sotang':
        'BBPw63Qkog1BqB/iB0QtThH7VwY6C2SmR2zB+SpFsK1P8B9M5H7TD5Q8GwGiOjH2KrD3I',
    'Thulung Dudhkoshi':
        'BBRoz4Qs690B7NuBiH8VxP0QjD4QhQlQ0C7K5KtMjB7pBzR9FyE/N2S3PkR5FWlFuX4B1FucoUkV',
  },
  'Sunsari': {
    'Baraha':
        'BBaq3sQ8jn1BlJFtH2IjTzGxDwSzT7MnZxFpJnLwBlL0FexG9LjiB3YpJ9RrLvEqErJ/E1PkfiaqItJgGaiN7dqVkSrHoNuG0ZgmBiXslBiKkBoN',
    'Barju':
        'BBS8zlQopn1B1JpBvBkJoIgI/GuHlKrEjKoF1YlB7GrQmG3EWxPkarK6HoDkQrL+OwN3FqEyE2E7KuB',
    'Bhokraha': 'BBJ83oQmrl1Br2BiP7IrLvJ+D/EjQzJkBS9KsgCjFyO+G',
    'Dewangunj': 'BBN4zlQ8sm1B3E7DjQsL5HnDxfgMSnUuUjesGiNqQLoGzJkKkToK6FG8G',
    'Dharan':
        'BBTy+pQm0p1BsI5b9PvEqT1nBiSZ0T8MyDvSkT0GuH1ImJGxBsLwJ4JhIoO0FqZ9M6Q5C6OnSgBvU9PlYwJ',
    'Duhabi': 'BBNs3nQ8/o1B1KtGpK0D7KxEvX1XvBiFjU7EyG9HnI/HwBjJ6biG+RlH2kB8jB',
    'Gadhi':
        'BBQ46nQypo1B5iB3iB9RmHjS3E/BpI8KtBxE1E4F/DlK9JoKYoG/KkcmF2U0sBiHwFqH/ECiT',
    'Harinagara': 'BBNg+lQunm1BtKvGjKjTnG0JhQM7HzMoI/KytBpHV6K0JhBkGsH5F0MuG0N',
    'Inaruwa':
        'BBRmtoQ8nn1B5GrC9CuP1JyDpZzwBnVnIGnMoNvEuFyJ2ImC+jB7OmKuB6CwFrQ8QS0PuJoEgBkS',
    'Itahari':
        'BBTy+pQm0p1BzdlPvI/K9UqJjMtD2EnamINjDnKoFtVmKkMiG/CzB9E+M8I+JnF8FuHL6J0LgOhGuIgQsD',
    'Koshi': 'BBNyjoQm1k1B9ZsCR1U5LtBzW7QxJzzB/Q3BZjQocoSuGoS8OwRsmB8a2E8P',
    'Ramdhuni':
        'BBWk6pQ+lo1B3IrHrFjRhKkF9M7I0B+E9FgDzDhHqFhBhBhStJnERzPsQ7Q5ErG+IDyemYyG+L3FZlBwLkJ6K4L+C9JyW',
  },
  'Surkhet': {
    'Barahatal':
        'BBoBqnyRwj4xBvP+LzHjJAoQ7W+RpDoQ5KuJtC9O3H/EzI2B1QjL3EgGtJ1BtCxS9MpIvJuIhmB7KsbvnB6DxR0RrI+L3OuSx0BkJlEsK6G8BqQ0OsDpDwVgI0T2KlG2IiJ0I/LPvO+GNoDoUkKqLhCgPsG4CrBmH+JuMpI4H',
    'Bheriganga':
        'BBV++sRwi7xBxEgO8E+IjOsbzGUvSqW/GkepGyBlL7L/O/CL5U3MxHkI9dsRvT6ClS2xBn/BFxLsJ9FmlByK1Y2LzOiT',
    'Birendranagar':
        'BBV8nvR6l9xBtHrMnRxK8E4B6IhK6CneliBnGhXoHvH5GnG5tBsOzSwd1LkFjIsNqIuCySuJ2BmF7F8hBmS0CsT5JiG2BwW',
    'Chaukune':
        'BBqBmo0Ro90xBjb9FpHlI3EqFhatF7btqB2MjJkMEkJrNmJoK2E7H2HyC+K3PwJvBXvExRrC7EmHpFhCsLpS7ClN4I+C+R9I9E9ItI9BpE3OqLnIoBlKuHLC/M8a9S6LhZmL+MrC8L8PmSnJqrBnagfnI6VtByU4F2F5H4M6L8K0C0L',
    'Chingad':
        'BBQ+tvRqr/xBhT+T3JlX3QjEpJoEnP5IgGvT0ZvTtFpG8E1E/H5I+BtHoS/JkvBgnBseuH9IgQ',
    'Gurbhakot':
        'BBQ6ntRw/+xB3c2jBhX6LpBuNhNnCvSwR7FnIpO+CjQ3b6gB9vC8P8EuL+LgItE6CvMktBuO6I0N',
    'Lekabeshi':
        'BBT+xuRyz8xBzQ8IvCiH0I8U3dmb5GxKjtBtOoC5OwSpW0GTkOrb7E9IyE/NwH6GiXnHmiBoG5Coe5IiK5EhE',
    'Panchapuri':
        'BBjBqnyRwj4xBPrIqI3H9JtMsBlHrG3CiC/OjKpLnDnU9GOQwOzIgM1IhJ1KmG/HzTqDvV1JMxJtNqG/c0NxC2FlJqO4D6BnKiHuC0bwrBiauF4EpFqHmIkb+FmP0mBhN+f9YtB3HmRpM6EnLkP',
    'Simta':
        'BBWwzrR65gyBerL0WnLwT3diKpGuOiJqJnE4QkE4JmXiT9TpE+lByDg6B3BlInQxBI7MlLyE/P7K3Q+OxbwEtTnJjI1Q5E6B',
  },
  'Syangja': {
    'Aandhikhola':
        'BBQq/mRwhlzBhXtEuC0J7OkR1HOpBvI9JmL3C1TwE1MrG9d4JAqG3K4H4O8W9EkE8QuPiN',
    'Arjunchaupari':
        'BBS04lR40jzBvI9BjC6J3JA+E4iBrOmDiB5HvHpInK2CzGtWuD7C7FtF0NxL4FhQgHwQ0KtP0HqC4KsN',
    'Bhirkot':
        'BBTkqkRk1kzBrP2KC2FrJH7C0cpL9QF/cxG+DvB9FwOrZA7ZiHe+J7KiJ0LoLrC8CmFzQmT8FuFtD8C',
    'Biruwa':
        'BBa6mkRounzBhJmE/FpJhE8DnNnG5DmH7IjEhCuEnNhOiEjG9GrGtGsQpcjNmRQuD5RgI+B8DnKwHwDuajGqHmHwJnNuEkFkD1EwHgbzD4DwH4N',
    'Chapakot':
        'BBdqpiRo9lzB7HqK/H9BtD6RlRP+HmHxBoY/M0FnHhG8C/GpLgB5E9KyMvdnJ/LiFnInIG6FrP5CxI2XvgBoR5B9G4J+G8PpFgCqBqMhIwLuXpIvBuP2CtF4MmF',
    'Galyang':
        'BBf2kjR8hizBnKe0DgJxMxCf8KtDpGzOuM2E4MmLjCxCmJvItGzE6G7BoavKCtD5FoF5KpU0E4CpI7ElByM9OoCtS1E9D+GzEzP9MvBxN2pB5P8M9OyFyL8JuBjE2N8HiG',
    'Harinas':
        'BBWi9gRu7nzBwO1Fe3Y0UiHuGrQ+GsGhEkGoNiOiCtE8IkEmEjH8MmGiE7DgGqJnKmN8F0R9HkBnJ0V1N7gBvPIjJ/HzdiH',
    'Kaligandaki':
        'BBQ6uiR4wgzBpHiOzP0HvKvFiD5WgInCrJhO+G9KrJpEsKzJzH3B1D3N0GvbqeiblLmYiIyR',
    'Phedikhola': 'BBK46lRkknzBvJgB8C3oByW1VtCzJyVmDkEwJ1MoQM6VpQuU',
    'Putalibazar':
        'BBc6mkRounzBmE1MzHhO4DtD1F7YrJxC/EwEvDxGyChOwIkBiB3GyXnNwI8IdiIyOrDdsbyK5KgEuKtGulBY0FuJjBlGyIkB2alH8N/J4BzIjGvLxWrFyG',
    'Walling':
        'BBjB4njR86lzB3c4FiEjN3MlF1CuFwBtPtXqIiIvLpBpMqF/BvDhKwKB0D3G3BvT0E5GwIuGyClJlLkC1E3M0OtMuDqGgB7KyMyCvB3JqIDuLoV0D7F4HoDjLiLhHdA8ZvOsZa4FyH/ClDsK',
  },
  'Tanahun': {
    'Aanbu Khaireni':
        'BBW2r/QmwxzBiH2H4B/SqJiE+J9HuCxR+SmQ3D8HwLkJ8D/B/CxM0NuCwFmR/M+azElDiBoX3HmElS9C7KsL7NjCtC9UpKlE',
    'Bandipur':
        'BBbygiR+7wzBvIqW1E3NhLrD1D0DiEiK9HfrHpG4D7HxSlQ5CyR9J+HnExFyFnVoL1LuBpS2D5D6JkGkE5IsSkL2LJiK3JoGgF/BkKyOjC9IwXnRmJ',
    'Bhanu':
        'BBYygiR+7wzBrCxD4N/D2FpJO7LwGvG3GrB6ExKgHqBkGhJ8O0TgDxN+GH2D7P8H7E6SuKiBwJ6NGqD4gBxG6Q9hB+hBvQlJ1V1C5Q/W',
    'Bhimad':
        'BBVigjR8pqzBnQ7CpEoHnFiU+GoMnGuL1O7Y6DlKnF9KjLnDC9FkMrExIrIpHkB+G7c1PrW0iBxEkJgI2PBgKwQgG0b',
    'Byas':
        'BBlBoolR+ovzBnMiBhBvJ5StK7H8E1D8P9GI/CyN3OzTnGiJ/GpBrI2NvEZiC9JtIvF7HoKhSV/LjKjE6I5JjG2F/MgSpIoNvW6T7B1K3K2BtLoTkGuPvT0JmByS1bgN0IsGjEqHuJOiS/LgF6R+vBmKwL',
    'Devghat':
        'BBbwvgRqsvzB9FwIW+NjLsLnE2UvGsCrBuSzLjVlO3BrHqF1DsO3MoGoEhNrKtIdtJkL5CyMrY9C1GhNtE/F9M+CnJ+WhHsEzIyQwDkLnI+Q6JoKyQ',
    'Ghiring':
        'BBcs6hRulrzB/fExQhGqDsO/KpCwC9L5FzC6G3EhCtI+EoDmC3M/M3QgIvU5GtByNtd5B/OyJ3G8F6CjD2G+EqB0D6RuPoR9G8cqHjBwIoIhMwEDwFmL2D',
    'Myagde':
        'BBPu9jR4gszB7RwbzJlBtPwTnTjGqD7pB0K/P7GrMwJlb2RiEoIgI1BkI8NsFpCwL+PwF',
    'Rishing':
        'BBZkxgRmlvzBnKxQjQ1HtDhR6ItQRjJ1FrBoGtH7E3CyIrEBhS9H/JsFdA9VyF2NiJ0B/BnPyQiGggBD+M0R1JigBLqbsLyLhT0BrOsX',
    'Shuklagandaki':
        'BBZ23kR2tszBlGzIrGkE1NtIoG/OhQ1FqCvL7NrF2BjI1JlJgK9QrEjMoJvVwKlGnF3T0SjP+DoSuH5EgIwTqK6HvG6EDmJ5FZvLsbsU8U',
  },
  'Taplejung': {
    'Aatharai Tribeni': 'BBKyt2Q4rv1BxR0ImB0I/Z0c3O1J5B5R0PnkCoM6EyTwdgR0F',
    'Maiwakhola':
        'BBOiz2Q6hv1B/QzFxTvdnM5EmChQ8uBnkByV5IqZuKoRrBiB0HpSsOtHrBlIqP3duZ',
    'Meringden':
        'BBS+/6Qkst1B7YzE1UwYxC6OtOoH5HuP9P/ClwB+M7L1DkHrOEla4dtZmIpPuHsBqVxSipBoO+MrD8TsT',
    'Mikwakhola':
        'BBgBsq3Qgzw1BlNpOzGxVizBzM+PgD6HtPuOnHqLndgR3MsR+DsBkJkXqDyDsGiJ7H6EsIsWmIxB8JzKoDd+Q2SmFuDkPkR2GnsB6sB/fY3CsGnRkCnU9UvMpYxVqE1Z9L/SwD7LkL',
    'Phaktanglung':
        'BB0B4h9Q4051BlTnXtH5Ttc9H5O7LvD5apd/zBvOnRlI6C5Z1hBhCpbpW7XqE5lB3NvQ+LtL0btCqS+KqUrEwMqYoU+UoRjC4CrGggBXosB5sBgIwIkHhE0RyM0KrHwBqqBmQ0GmT6V+U2D6NkSZ+GuUqEhD8P/L7BnLuHuEupB9T8gBwMqcnMuV2FqMzRqHiJuYjRmmBxKqDzKzRvSkPpJ/JhS1B7DzM',
    'Phungling':
        'BBRgn4Q4+y1BnSpH9MyC1IjL3VOsD/QoKzFpBvG9oBhjByQtSpBpIkLlIkPyC+G+VmZgZlEimBmGwB',
    'Sidingba': 'BBNy93Qui41BpTnVxxB5SzbjfV1sC+b8PmLlDoJkGuM2e0cwdsHuQ3LwY+NwV',
    'Sirijangha':
        'BBpBy93Qui41B6BtG9NvV4LvYrHtQzcvdhLvd1JjHtP2BlTpN+KzVwHyD2ElSmmBqD2IkL+MxCoSqHgGkMtCiM6Z2hBmI5CsZ0iBoT0kB2C6Y6O8Luc+HuH6TmToXhHgEzPrGxMpP5V/D/P5TjInEvE2DxS5NvFkF7IvDjKlL7KG7MuO',
    'Yangwarak':
        'BBNsp2Qqvy1B3Q1DrEkSvHxD9K0VtFnB9Gtf4D3e+HnW4K3K6pB6iBqBwGnK0F',
  },
  'Terhathum': {
    'Aatharai': 'BBMm8xQu6v1BqZrPwRxB2iBjRiU5XvB0hBzJ+b6B6RjhBysB7LjElHzQ/WnH',
    'Chhathar': 'BBKmjxQqot1BlRye/O1SvKqF3chkB5Cjc+VuBm3B/btLyX4PiV',
    'Laligurans': 'BBLmjxQqot1BmH9c3PhVuLxXiShB+HwH2TmDoKua7F0O/SapIgO',
    'Menchhyayem': 'BBJ490Qqgu1B7U6I/QnBvL5S/MXsLrNiKhboU6HwboW',
    'Myanglung': 'BBNs/yQq0t1BjgBkNlPqjB5GxNnXpQ2QtekalIqI/N2SRmG7O2IgKkOdhKib',
    'Phedap': 'BBM490Qygu1BhU6Xna4N9Z+E3ZwP7JpOkGngBqHzKuVjL0XlB0L8S8QmB',
  },
  'Udayapur': {
    'Belaka':
        'BBaq9pQ2vj1BuE/L7LxG+P1K1BjO0KpM0LwBU+J4RyRgDhI+F+C+WlK/BgIsP6FiN+N/CqHgNoY/C0FsO29BvX+LzL7JxhBzGxfjSnI1HzE3WqG9P',
    'Chaudandigadhi':
        'BBdontQqij1BnN5OrP5F+B/H7WmK9F9CjCmIrIhE1QjjBtMqBhehnBK7EkMlDiBlV8Q+FsV7CmDrPmL1H+NMoB2L9GyJoQ0MnL0J4VZsNjH8M8VO6gBuHyKX8c',
    'Katari':
        'BBsBwsxQ2o50BnJtD7BhJnZuJdhOtSwDxHpE8D/EvEjEzdqbpOlNtP8NhC5JnKuBwN/6B/WvL6IhxBpOrZsiB54BgHe7Z+nBwJ4B2FkV2W+P+I2TgBmYwpBiS6D3JqKpCwH3K+UqKqErNzEpLkGtKqBsM2WwKlEyPyY4N1I6Q9JmC3B6KxIhHTiMjR+I',
    'Rautamai':
        'BBZkluQ+y+0ByDnQ3KpsBzKjFuBlFrS1XyKsCsDnEkDoEkG7H6f4ByPnFkF7HoN2D4NoOO4JvCyMpL4IiB6NgI7CqB6HkO4K5BqF1O8EtJ6M',
    'Sunkoshi':
        'BBPw0wQyy90BtOpLpB5H/H8ChB5NgLpI4C3L7FrQ2HzF2UqCkOxL6ZnFgC8H5Tm0B9QiT',
    'Tapli':
        'BBPqjwQ0w70B7KpK4HtO1GzPgDlNwLvVsZrJ8BiJoJuDoHqR2LoJuI2Y5ZoFjOyL1UpC',
    'Triyuga':
        'BBlBkluQ+y+0B5hBsF3GyiBrNkH3VaoLzJnQzM+GxJnB1L9NLlL2HlDsPrV8C7Q9FzQneoQhKlDlT9LtNoKtMlJzJqF7E5FrT6GvFnCxJqQhJ4KkBiE/M8XwPwCnRmbsIsJ+J2MjBCkL4c6hBtBmFsKwEgL+sB',
    'Udayapurgadhi':
        'BBfgowQyl50BtO4hB2G8O5GkPtL5BhF8HxPoFhgB3BzF4HrDjElJwDjP3LBjL1MkBrJ9Jlf1J6FpL6O0O8JWS7VqHjBsR1XyUlCmC8JuP7NqOmN4clbsFgExDwFoH6DuSvD',
  },
};

/// Boundaries that could not be joined to a canonical roster entry.
const Map<String, String> kUnmatchedPalikaBoundaries = {};
