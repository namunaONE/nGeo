// GENERATED FILE - DO NOT EDIT.
//
// Lossless boundary geometry for all 753 local bodies (palikas) of Nepal,
// encoded as compact strings (format version 1 - see palika_boundary_codec.dart).
//
// Source: docs/palika-boundaries.geojson (l3lackcurtains/nepali-geo-pro-max @
// 117fd0f, MIT; originally
// younginnovations/nepal-locallevel-map (MIT), MIT). Coordinates quantised to 1e-4
// degrees (~11 m) and stored as zigzag VLQ deltas: the round trip is
// bit-exact, nothing is simplified or dropped.
//
// Regenerate with: dart run tool/generate_palika_boundaries.dart

/// Version of the palika boundary string format used in this file.
const String kPalikaBoundaryFormatVersion = '1';

/// Number of palika boundary features carried in this file.
const int kPalikaBoundaryFeatureCount = 753;

/// Total boundary vertices across all features (ring closure vertices
/// are re-appended on decode and are not stored).
const int kPalikaBoundaryVertexCount = 16101;

/// Features joined to canonical roster entries by name or
/// point-in-polygon. The remainder is in [kUnmatchedPalikaBoundaries].
const int kPalikaBoundaryMatchedCount = 753;

/// Encoded boundaries, keyed by district name then local-body name (roster
/// spelling), e.g. `kPalikaBoundaries['Chitwan']?['Bharatpur']`.
const Map<String, Map<String, String>> kPalikaBoundaries = {
  'Bhojpur': {
    'Bhojpur':
        'BBT6t0Qo9l1BpPtJ7XhF4BzG3UrI3H2HvS1DvSwCgQvPnBzNyZhX4T/L6V/I6QwK0I0LtF+JuL+H/JkQzE0P',
    'Shadananda':
        'BBU6t3Q+2l1B/LiC7LsX1O4OpOLhI5FvJgMvUgF7IvCqH7c3H3lB0EzPgKjQoGgB+G/MkP5KgRsMiExF+S8CoT8uB',
    'Aamchowk':
        'BBR85vQsrk1BvNwNnT2KrOrD3P0P9MrpBc7K1KvSiNthByMyJuc2E8E7IwQuFmI/NoR6FxC+c1S8V',
    'Arun': 'BBOgq0Qunn1BrFxBnRiVrQqGvJ8OhVKnOtP5IpS+Y7f4btEyH5S/C5IykB+KkG8Q',
    'Hatuwagadhi':
        'BBQqmwQy5m1Bhb0I1K7O3S1J9I1F1FgGlEja4PzPsOsDoT1KwNvNkJqLqHjBmI6LqHwXtJkR',
    'Pauwa Dunma':
        'BBOstxQ2un1B5TlVnTC8DzNiNnL+C1P0LjKyTjDwS2D4H1H4UsIoBuPxH6S3buE',
    'Ramprasad Rai':
        'BBPsnyQq4j1B3R6QoB0N5diexGtTlI5LpHkBjPzZ2S7VwD7ToW1N8IvSyNgRI2HyNkc',
    'Salpa Silichho':
        'BBZ6t3Q+2l1B+BjQnT7uB9S7ChEyF/QrMtGKhEzPkUrYwUlPiJmEiOxMgOzCoHsPiL+FTiJnKgQzDySmHiSjEmL6LmK3CmNwC6JtH+SpNlK',
    'Tyamke Maiyum':
        'BBZm40Qilk1BtL9HuF9JzIzL5QvK5VgJna2SjE5QxNjcH1HxN/QoDzImLdiDoIqT0EgH9FuVyKiMb+QhSqKiILuWkS2KmIwMoDkSvQkW',
  },
  'Dhankuta': {
    'Dhankuta': 'BBN0ouQ01q1BjGnS9DzblGxRshBtFoMmGoSiRgGjIsLoTzBiSnH+MjWYnSlF',
    'Mahalaxmi':
        'BBP6pxQu8q1B/N/UqJtQoDtf4SrWqJoP8K2C0N1GiFoR/EyMqF8b9E6J5JepTsUjIxH',
    'Pakhribas':
        'BBOgoxQ2op1B5egJ9K5R/FkIvY7WQ/M4S7SlDnO8bnM8N4C2UgW+HwR+EG3SsW',
    'Chaubise':
        'BBV+5sQ8tr1BgLpIoX5C2E8D2OxEQqQ2KiN1DuJ6KgS3PkUpVxBrQ0FrJ1F2C6NhE0LpN2KqBtNxDre6InCAnMxI9U',
    'Chhathar Jorpati':
        'BBSg5uQo5r1B9I7GhB3SrG/J4P9HoSmFkWXoH9M6BpU4R5FiKqCP0JpJuQgOgVzQwFnR2PlWoEzC4E',
    'Sahidbhumi':
        'BBPsivQu1o1BzI1ErhBuFN5U6D7HzI5E7C3KoLpb9IlCqSvI+I2F4S2JoP2PmDoO3S8S',
    'Sangurigadhi':
        'BBV+5sQ8tr1B3C7RxMrOgFjb6M7QnFra8H5OlJhJ6IrhB6cUnLqb8C4K0I6E5D8HB4Z2G0M+D0biN2e1OyE1E7DnX6C',
  },
  'Ilam': {
    'Deumai':
        'BBai9rQ2i01B7C7MiFvSzGnKuHzLwN1F6K4GoPuB6NlJ6SsOmM2QyXjGgKrOuTwjBhGiG5VuF9MnFhPiQjE8N3YsH2F3O/D1J/MrFhI4DpMvKvGoG',
    'Ilam':
        'BBjB6xwQ2g01BxO+LpC4JrKd7S4MMoLkMIzMwWlJlB/LjMtcOpLoEsE+VtCoH9MqGrH3IgJ1X9F1FhCjYrXvHvFrJ2EnNuRTwGnGqMwKiI3DgNsFgE2J1F4O4YrHkE7NiPhQ+MoF6VtFiGhG',
    'Mai':
        'BBao0sQ6t11B7IoPhMjKnW4NpajDnNzExKzO/IzBhIjc4B5KtJ6DkD5Q6N/TiczJwN/H0E3LgToDiEzHmMsX9H2C0GoKhFwSwD+JpFmQwFsJsXwH',
    'Suryodaya':
        'BBgBo+rQ6j61B6KzL7B7OhKzJ2E1RqGlB2H7bvC1L2ExKrK8D5RrM3MvRoW3NiMkK0InPoJ6Q/I2XsH4ImPlK8L6R2BkR6PYsRmBsFyMuO2PlK8LzB6KtVrJtS+P/N/FpSkW3T1C',
    'Chulachuli':
        'BBZqsqQg0y1BvgBiQvInN7IxBThQyW5lBqF+BiZ5M6GhP8MiKwKvOwKsD+JvIyGtO+M1PdmXvFuSvQoOzHhHpPqDjEiM1PvEnM0KpF4WmJ6J',
    'Fakfokathum':
        'BBNg2vQqxy1B/JsOxXkGlM1Q5SrO2HnEpJrXB5P+KkFiLnQ2PiF8e2iBhF0M',
    'Mai Jogmai':
        'BBQkwvQqv41BlR/IrFxMrRlB5PX1BjR7L5RlEpZqLnEucNgMkMkRY+G8emJgKgFwKSoR',
    'Mangsebung':
        'BBYu1tQ4my1B5NmJnPtB5K3G9O6GnKxPhE0H/SnDzE4LlPoBqB3LlJ5JqF3WoMzK2PwEkEhMqPpD0HiHwQnO2G3LyLwZ8T8HXkOqJsX',
    'Rong':
        'BBdo+rQ6j61B3a4HzB/GsJ7L/P3Ga5HpOnIuItN4YtCpL5JmFlGhXjHzDvF4RnMrG9LtIjHX3JwPnLmLsC6K4O6RsMsK7D1EyKwC2L1H8bpGmB1E2RiK0J8B8O',
    'Sandakpur':
        'BBT0gwQk331B/EvKlJ/J9G7e9GH0L5VjMHLnL8S3MsKeqC3JyO9L6S2V4IwjBlDwGkC4ZtKiL1GlDnZwN',
  },
  'Jhapa': {
    'Arjundhara':
        'BBUy3qQiq31BlSxH3NhP3Fgc3OsD7StHlC5P2FpDtBvT5H9OgSWualMyK0OoN0E2TU/E6IjNqFY4JuIkHsG+L',
    'Bhadrapur':
        'BBT04mQ8541B5J6D/DzHtMsChgBOvUlJkD7RiOlCvDlQ2RkMHmG6Q9IkNsFyS7DsInGgNuD6D8LgJkE9SiS',
    'Birtamod':
        'BBOmwoQqr31BnOepO+JxKcnH/GgF3ZzOhBhE5SsWnD0F1L0cgJyFoIuBwT1FqD',
    'Damak': 'BBOkspQ+hx1BpLiFvLpE9O9QvOhErNpXoP4JmML8K1HmWgH2SwB4IsOqMyFhZ6M',
    'Gauradaha':
        'BBWogmQuxy1BvUwE7JnW2F+BsC9VjG/M0MhH/QtHyF7Rgf9GqMqD8UjGiIsM7GsLgG2PoV4HtG8ItLjFrSyIpG8I7IpEHmU',
    'Kankai':
        'BBOwopQ2u11B/L6HrKpEzKoKlWnJsExMjB5UlR8FsEhPgK3BkDlJmhB8J6PgFiIkc',
    'Mechinagar':
        'BBY04mQ8541BiQpE+ShSvJtM6P5KmhByG6GuF7DsSgYAIgJ1b0MyT+E0TlEoSkJZ6HgQ4GrJ8LxF+IxgB3DvMpJthBvCzMlNnM/BzXlM',
    'Shivasatakshi':
        'BBT+lpQws01B7P9ElhB7JjDmJ9V3BnB7NrHgBjS9L6D3VwOhCyTnPmIgDyYV4L4L8PwDwIoNvK2QjD6QuJ5D',
    'Barhadashi':
        'BBVqxnQmz11B5GgMvUYpE1OvNhBgB8H7JyCzFmEhTzE9IxHtHsEH1PgIWoL9KmS6FwFrIwHoDiO3EgQyCiS3JkB6U',
    'Buddhashanti':
        'BBSosqQ4941BhWuHxT9E2bzMH/I/XA8DrSxBpIwJP4F/b4NiPsSwLzJsH0DwFiXkHlFmGqL6J3YuC',
    'Gauriganj':
        'BBUihmQqsz1B3bhBzKhJoEnLlJzJnbtI2E3KnGzImMhOwFjWiRzL4DwOgRuHzMiHkGgNrC+V1F9B8JoW2TjHuF4H',
    'Haldibari':
        'BBSo+mQyy31BrX0HjNrF5Q+IIlG5NvJRpVjI/NmL3HQnKqXiG0FlE8JxCf7HwNiBwGgkB0OiBjD8T',
    'Jhapa':
        'BBWsjnQ2301B7QqBhO4EvHnDvFsIlS5F5IM6NrLrGxB7H9QrJ6B3H9HoC5MqGeoHrL0KiJuNlCmUqEoM8KsHfoB8N+LwD',
    'Kachanakawal':
        'BBW07kQwu31BTkNhOmCtDyR7InG3T9c3OvBpCtNsGnKoNH8CjQmNvV4HrJkKgEmBhPqL+K7L2DI2PuHrEmEsQlL4HkIgO',
    'Kamal':
        'BBWu6oQo1y1B3S1NxYWlI/CxToP9UlCwPvJIlU8IqEqG7IsSxIuLkFuG7InV3H/F1P8GrL0K4MwOiE+O+QwLqEgN7E/TijB',
  },
  'Khotang': {
    'Diktel Rupakot Majhuwagadhi':
        'BBX6x0Q+wh1BvGvI5RvD1MwC7EtSnLjXzNlQlBzWtI1L8SxLDlPmI3JoPD4PoHiRwfnBuS2NiCsQnUwHqGzHqXjFqWLkXjHiM',
    'Halesi Tuwachung':
        'BBdu/zQ4t90B5P/GnPElI4JEmP7SyL1OnD5R7VoHlS8JhIkI5RsElWiH5RlK9ahN1LlHtY6B/JgIJ0JzKG3J6SiNyB6KmMkQ8E6WyU8SNkV4G0SJ2VnHoI',
    'Aiselukharka':
        'BBS453Qimg1BjRLrFlHpf/F1C5W1V5Z2XrG1BhJ7NhIlE3PogBrCkPqBsDiSVoa4KkMzC8K+EwJsPgM',
    'Baraha Pokhari':
        'BBP0uvQkig1B7XZzF8P0EiIzQ+B9JwPvQqInB3hBzMjSlB5RuHjUwXtHoeN2OwLmEgN',
    'Diprung': 'BBNmvyQsq/0B/K0Q1CiU+B4StXnHpQpmB9StfrE5YsN9DoPvN4Vyd2OoDuI2L',
    'Jante Dhunga':
        'BBR6+vQ+ni1B9GvDlIgOvQtF7E8Itc1ExMxJzGzUwQpI+JvP0Q9BzEhI0F7P8XaoN4kB/BmNwM0F',
    'Kepilasgadhi':
        'BBU6x0Q+wh1B2OhMkHhMMjXkFpWsH5T4MkK2C6WqfgGsFmHoRWlD0Q+CwV7PwChOyMhJlEvUmP9S4W1H/LjS1K',
    'Khotehang':
        'BBR6+vQ+ni1ByHnOvMzFgClNnN3kB9CpYlE/M9LpO+ezFmJ1MiF0Y+Suf2KoawM4W1OuS7D+N/QoL',
    'Rawabesi':
        'BBRmv1Qsr+0BvOoN5DsJ1NhCoBtSzQ1dnI/XoHnI4C5Q4J6D4J0WwQuDkNyKgBmJ8NiI2BiJ1XsG',
    'Sakela':
        'BBP8yxQolh1B9CvIwTiF9B3S2ChUyJhQ+O+SoLkX8EuS0aW9QiShMctVxK/G+FpTzE',
  },
  'Morang': {
    'Biratnagar':
        'BBRo2lQyxp1B9O3G6BxLzK1CxLgIhQmBtIhGhRsGzF7Y2TG0IxOqIqDsX/F8VuIyDiN5GgL4H6E',
    'Belbari':
        'BBQmgpQw6s1BprB3LlaqFyE5H3K/IgC3L5JhU+WnIiPjEuRiPoRxGwMiCyNkO4LkOlKgUrOxE',
    'Letang':
        'BBZ+0sQo8t1BtJuJpLvD1XqF1a3HrOwUvQ0OzM2BuHrL9DpP/IuEjCzLW9mBoHtOsOyEmK/TkN6HqGjH+SrCgKwEoQxEgDyMpFmNwP4P2H9B',
    'Pathari Shanishchare': 'BBKmpnQk6u1BnJmE1J/H1DnN2QpamawC8JqH6TnEYgd9OuQ',
    'Rangeli':
        'BBSw0mQojs1BhRnBkCgVsK4K5PsPnZ/SrPyMuD4EpWmL4C7Q+FjfyP9GoDlSuFpF0OMoC/GyagBwF+Q',
    'Ratuwamai':
        'BBS+2mQ83v1B9SPvaiFrVgOlWwElGvR3HehC5YhFzPqR0L0QjDyLlPwdb+P8IiJpGiTsNoJlEgB4S',
    'Sundarharaicha':
        'BBMg5pQmyp1B9H4d2CwRre7BnRyGxOpNxD9M+DzY8DlGiDrKmYvJ0RgP',
    'Sunwarshi':
        'BBQo2mQq2u1BrJrFhJqG9P7IvdcxLmPzQkDjK7NyHlTqjBhRtD3EsPxMoZgTyEjF2XsK5J2S',
    'Urlabari':
        'BBQs2pQ6/v1BrPXlW/G7K2HlMM5JxJ/YqBoT/Kf3S4jB0HsL9OwN9I+DqPtHsL+M/B8NuN',
    'Budhiganga':
        'BBPq1nQgkq1BlDjGhPnC3RhT9e9L6G/KxDhNkK5DyQiMiH0LyKwEsJzD2QuJoBoQpHI',
    'Dhanapalthan':
        'BBOy8lQgjr1BrIyJzOLtFqFnDmSpQoEvKxVjCxY7GpMqSpDe/E8QO0H8K8IwC',
    'Gramthan': 'BBN61nQi6q1BlSkB3ayJ9JpGwFpMzCxEf/O3MJiF/MgB5PmXkH4RiTiPoC',
    'Jahada':
        'BBPy/kQ0mq1BnTtBdgFnSoDtM1H/QmBpI5K8O9RmB/N8IoFkO3BuIiGiMnBzC2NgUiR',
    'Kanepokhari':
        'BBOk7oQq0t1B5ToEvZvLvasGzOtHoLnKrK3KjC/UoTkByIkJxE6HmapFiUmEuS6I',
    'Katahari':
        'BBQkkmQujr1BtG1C/P3N7IvCvEnN/ThR0C1NyP9H0K2C5ByL+O4GlC2M4MKgBgP0CyEvFqM',
    'Kerabari':
        'BBZgysQmlt1B/IOvP3PqFlN/CxMnQyE/JvE9SsC9MwGnSpVxNjO8RF1CvR+H3diN0IkNxByT7HmLmK2U0IgEuJyMsO8CsS1H8TyI+UAoM',
    'Miklajung':
        'BBTs2pQ6/v1B4G5P7NtNmQpOsOvU2a4H2XpFqLwDuJtJ/C0M+C8U9M2PxGuO9JwIvKrDvKwO7MhKhC+NhRtE',
  },
  'Okhaldhunga': {
    'Siddhicharan':
        'BBf882Qqm60BpIR9R2J3lB+DvBsOhRkB7EyY5H1D/GrgBgKtGqL6BF5K0MlWjFjMvFjhBwTqLuN7BmC4UwQ8QB1S2H/D0M2K0IeqGvJlDvL2NnKgY6IxFiIpO2B2BqUvI+D',
    'Champadevi':
        'BBT422Qgp20BjNqGZmKpQnKvJ4MjU1ON/TkF5GzalL6E7KrKlXsKxPuVuWgG/CoN+RySzHqKsJvC8SqJ8C',
    'Chishankhu Gadhi':
        'BBPun0Qkh80B8CneiRjBwBrO4lB9D+R1JqIShO6Q5O0D0B0WhC4fuIgNxbwEtHzL9PmC',
    'Khiji Demba':
        'BBVin4Qiy40BhQ9LK9F5M9UzEuFlFvP1KpHhEjQgL+C8IvN8XxXoCpRsI4E2IwR2SyUsMqIwDiOhGuJsBgOnU+QNqJ',
    'Likhu':
        'BBP422Qgp20BTtWpJ7CwC7SpKrJxS0HhKrMgQ/QmPAkc0GuNqM6O2FnCqR7XyX7IwN',
    'Manebhanjyang':
        'BBSk3zQo060B7S/U7E5WlMjQxB5K5KvL2LnHsJlTsIjG6EoIkLVsLsM8EqMkJ2B2FoiBkFkMzMmWG6K',
    'Molung':
        'BBV8j1Q8r40BqO5F4GrK7D/L6J1GiStfiFqQ2KqHmFwP0EtFgRohBtMnD1NoKmDwLpGwJzIdzM1K1HgEC2SvQ7QlC3U',
    'Sunkoshi':
        'BBV8j1Q8r40BzC+D5cjO7EpMrLrMjLW1FnN+F7O6QtCwB1PqJjU0amLjF6GOgUkU2OwJ3MqQoK9JwP5J2G8DgM3GsK',
  },
  'Panchthar': {
    'Phidim':
        'BBV49yQ6tz1BhRgDnE2UlS4N1D4QpO5JtSvZxEvKsC9RsFhDwFxnB+QzHtHxHsGvXmQiGuI1DwK6PtE6EgJiTiBsW+J2K',
    'Falelung':
        'BBVwyzQ6/21BvYAvVtD3H7J5PI3B5nB3FrPkNuI2D3QmS3NoE1UsT/CuHsHgIvGsJsF/BsL6G+F9C0NiJsJ/FyPzLsb',
    'Falgunanda':
        'BBOktwQg3z1BjNpR9MtYoFpVvQ7TsXxa+D+KgazL4J2N7C+TuHyH9Q0HvFynBrFiD',
    'Hilihan':
        'BBU410Qmty1BxOrGrDskBxJmG3K1C1OiE3D1U9J1KhBrW/IhTiEtGsUwF+FsP8LkEkK5KqR9d2F5D2MmK9HoWSiV',
    'Kummayak':
        'BBPwkyQ82w1B9JkChTpHrK7I/Z0L9D9K1JsO/GlgB2D1T6MnBsFvtBkNoR8X6Q8I4VyLgN',
    'Miklajung':
        'BBYw1vQ83w1B1NmMrO5O1PhFhLoQ9KjFhTlG3MlgBPjhBoO/MiEzL1C5NsJ2FsQzFwVuBZ2GxT0UTiN4LoWoI2SwNJ0DjMkLNsG4Q',
    'Tumbewa': 'BBN2uvQkwv1BnM0DzDkMvNKnI1S3LnWUhNyTzUyLtYqbocgMjErFwtB5MoB',
    'Yangbarak':
        'BBewyzQ6/21BJvY0LrbgGxPhJrJ+CzN5G9FgCrL+K7IsDrkBkMmGyK6mBhE0NoEyUzDmToB6P6L4OkOyKiDiI4PyIkZ4F+L2GwPkTnHyHzItS3avFlVuPpH3I9X/MzWP',
  },
  'Sankhuwasabha': {
    'Chainapur':
        'BBW000Q87s1BwH7ViLjPtB3a7HtavU3clIzXjSrRgL5GyKnPqYgE+LuJJ8fiSk0BkTqOsCsJsOoWwJwI1U6HvYoVxLkD5K8L',
    'Dharmadevi':
        'BBT2x0Q6yp1BhH2F/PyarEwRxIgP/GoZrLvL7BpTlOlJ/KOqTrU6Jd+E5JpF7bgFxMhFnRiGlLiMpFkSsR',
    'Khandabari':
        'BBS6+3Qklo1BtWwB/J/M3RgE1RzY7MkHlT7DwMpDwJ/LiI6FqOM2O3O8LrX0TvE0VgRd2XhJwN7DsP',
    'Madi': 'BBM000Q87s1B3gBzQ9JW4DrYyI/OsEvRgQxaiH1FmM8O8HuauB4ahLkP',
    'Panchakhapan':
        'BBRyo3Q67r1BhKxGrOnWrCrJjTpOhSj0BK7fzF9I6K4B8MjHoP+V0OuUgT8PpImKmC2MhGuZuJojB',
    'Bhotkhola':
        'BBwB0i8Q2zt1BgN1NmLwD5BzkBhJvT1QrL7J3RBhPuHpPqRtVmQjHoLiMqNdkNvO0QlJchV+W1kBfkhBqMiIkHyQ5EqY7K0I+B4a2JoHgJqhB1KwD3EnRpH8ckPuZ1BqdwO0P7IgPpU+B9FsN0NwNsBkX7PhDhN2HnS/LrF8DrMlOhNjBkB9K7W5ISvR0KnDoDvIpY1J',
    'Chichila':
        'BBO0q5Qsgp1B/VGlQrHS9I5HlW8DrP0MppBoLiMwEqPoOgDwHmPeoM/I2CrEgM',
    'Makalu':
        'BB8Bss/Qgzm1B9W2kBbiVzQmJjNwOpNenLhMlQkHpRuVtHqPCiP8J4R2QsLiJwT6B0kBlLvDhWyVzV3KxCpJ7TrT/MoDpXtJe3XzFtPZ97B0H7GxEhasE/LgJ1CpIpbkFzPqJlCwLuNsP9RqIdkJ9QmSjPmRpGwQlSwKpEyKrN6Ena0LnKwZyC6O+Q+G9UuPmI4Q7J6PpE4K4IwSsBkFoUxE0O7O+IjH4PpUsG5EwLzMS7MsL4BmJ',
    'Sabhapokhari':
        'BBVop5Qits1BtPNrG5GnRsBpZtKG9JtJnjBiGtZlC1MqIlK/S7PxJ9RkP5DgKgNuWvB0FiUmQsHgWF9GuKa+7B0FuP',
    'Silichong':
        'BBiB6r5Q8/m1BrOjDvEpPnLhM1HwBmEjXvC5J4ClN5LlKkElLlHhS0DxSoK/PEtI0PwN8UpMuP2O8KDyH1HueuDyQgPod4DyUyLnBoSxKsNvKqEvQmSlRqGlSkPjJ+QpIerP+RvLtNpJmC',
  },
  'Solukhumbu': {
    'Solu Dudhkunda':
        'BBkBqs7Qwo90BpMjK9ShB7DtFApYrRlBpctN5bsFxDpH2G3b3iBzBlC9MwOzQwI9D1BpUqO1ByFhIidxLsC0J+RqOwB6G4N+I4G9DmM4K+PlLyQiJsGgMuMsHyTuB6F2GgYuH2EiW1d0TFkWvSoJhL8P',
    'Khumbu Pasanglhamu':
        'BB/BiwgRw2i1B7FnSyBrVhM1QvqBsJrJhEpH9M1K9BvB9LrRpQ1UrBpiBjJ/LjLwIpR3XrEhE/FwF7OyEuGoG9QsLlFocoGiL7PwSnJGjW2dzTrB7P+JxF+UgC6G1QsayImiBN2LvD6F/OoShH8JG+VsFqTuJA4HsLoKqFjEySoC2DyH/GyRlQ2DpDgRwG+N2IiCyIuRhD4enL4F9G8KjShL3EqQ/LwK2CqJ9EuOgIoQtTsW1FmW5PiFlIkfvSrB3K3I',
    'Likhu Pike':
        'BBRyq7Q6p50B9PmLlM3K3G+D3N9IvB5G9RpOrCzJvJoCA7IoU9QrB/NuG1Mka+MyOia6LwKoE6V',
    'Mahakulung':
        'BBnBw63Qkog1BqgBvJwC6H6GtKvG/N6Q9GoWqBuG0F6TbqFrK2LkLqiBkJ2UsBsRqQwB+L2K+BqH+MsJiEwqBrJiM2QxBsVoFyR5Q6KtPlI9G+U5O9QvZxClPoSxUxLnd3DxQ/OtetDxH2H7KEtP1O7UqMnFpJ9U3KpI3kB',
    'Mapya Dudhkoshi':
        'BBX+j7Q4i/0BtPvDhE/FzT3I9KHzPjP/O3GyKhUnUjVsGzfyLTqcuNsRmBAqY8DuF+SiBqMkKrLmFnG+QxEtGvF8OiEgG4XsE',
    'Necha Salyan':
        'BBN633Qgz70BxKqMnHpB1S4PxEmRlP5NiC3fzBzW6OzDiPtSmC+M4iB0B1G4b',
    'Sotang':
        'BBUw63Qkog1BXhVkD3QyPzQhH7V6L7BiRmH0PkP+KI0T4IiEgG4PwDpFsK5TctGzFnWpB5Q+GwGgO5GuKvC5H',
    'Thulung Dudhkoshi':
        'BBSoz4Qs690B7NuBiH8VxP0QvEyO1O/N0C7K3KjMWnarDhShQ9DwE7N2S3PoHqByKpMuX4B1FucoUkV',
  },
  'Sunsari': {
    'Dharan':
        'BBVy+pQm0p1BsI5blM7DTxO6JpFmGlUiShB6T8MyDvSoT0G6P3IX4LmJiJ7H6OoFsa5M8Q/I2R1UzIlLlKxT8HjNyB',
    'Itahari':
        'BBRy+pQm0p1B7X/LzR/OtQyJ9JI7BtQ0DhNiHwCoBpgB2HLyIsC+M8I+JnFuFiRoI2GmBuPmM8D',
    'Baraha':
        'BBYq3sQ8jn1BrLiBjFuHnTzGxDwS3KvIjhBtJrK9LW7VjiBtbpIrOtMvFoE/IzEnQ8eoaoOzI2J7d2YkSpHyNoE0VyI0IikBwTyciFuF8Q',
    'Duhabi':
        'BBPs3nQ8/o1BhMxGrJ0DxKvEhHzLxQhMnLiErKlHsG7D5H1IwBjJ4T2Fga5GkJ+Nub2V',
    'Inaruwa':
        'BBRmtoQ8nn1BtIFpBoNpHgF3O7S/Mnf9U9HBvMyNpE4HgL6RnC+azM4J4HtNmK3BmWqJkEYmS',
    'Ramdhuni':
        'BBQk6pQ+lo1B5IxHtFhR9JoF9M7I9CBXlSpJjE4BlWuNlK0E3G0eqYV8VsK+LgGkGlGmU',
    'Barju': 'BBO8zlQopn1B1JpBvBkJ6H2IxG4G/sBJvGnP6F7FWxPwY/J+I+CgRpLsOkN9L6K',
    'Bhokraha': 'BBN83oQmrl1BhbuFpKmH5RoC3H/KpKkDuBpIhMtI9CxI2LtEwaNmaHyO+G',
    'Dewangunj': 'BBN4zlQ8sm1BrE3D/QqL9I9ClLyH3SiEdxQ2UrhB4EiL6SqB0G3JgK0SsKmG',
    'Gadhi': 'BBN46nQypo1B1Z5UjJ9N/Z6GjMxM+L5K/JrJoN7Isf6DgNof4O8SqH/ECiT',
    'Harinagara': 'BBKg+lQunm1BxK/G/JzSzG4J5SpBwDhWytBpH+CyIiMuItJkZ',
    'Koshi':
        'BBQyjoQm1k1B7PnChK0ER1U5LtBzW7QzFpPMtSrE9R9Q1BZjQocoSqCgLgT4YsmB8a0EoQ',
  },
  'Taplejung': {
    'Phungling':
        'BBTgn4Q4+y1BrSpHvM2ClFzJlUO/BzS+IjMrY5QxQnSuQjSrB1HuMrJgO6CkHmWqY4XuB0Q5E0W6FmByGkQ',
    'Aatharai Tribeni':
        'BBNyt2Q4rv1B3RyJsB2H7JoNjQsP3O1J5B5R0J9biCljB+DjF+Z6TkG0O6PyE',
    'Maiwakhola':
        'BBQiz2Q6hv1B3QvFjGzOnbtX0DpM2K/LyLjDwYnVyV5IqZuKqViCpVyStHrB1E0KhT0TlOwK',
    'Meringden':
        'BBX+/6Qkst1B5TpH/Q4M3IuOpE+QtM+EhI0PvQzCnS2Drd8I5KhD4G3URtUmOvKiTzT2EzKuHsBqVxS4TwHoJbgMwHgNnD8TsT',
    'Mikwakhola':
        'BBiBsq3Qgzw1B/MhO5G5VogBxIoS1DwQ0CiIzPuM9EqE9Q4ItOgR3MsR+DuGiI2asKyIYqY2JnDwIzKoDRwR8W6IjB+KkR2G5R+W5iBsZzX3C3CsGnRkCnU9UvMpYxVqE1K5I/OjD/SwD1L6K',
    'Phaktanglung':
        'BBhC4h9Q4051BlU5ZxGrRzbxHrP/L5C9YlQ3XhD7MrZziBlJ4BlFlMzTtUuChMxEtP3JlGxGjQ5FlB6EzWtBzQ1M7P2L5KgTvDgPkD2K6IyVpEwMqYoU+UoRjC4CrG0X4C6iBrZ6R9W2N4EoSgMuLjHgDia7DmKmTuNM4F2nB6ToNqRJoH+TgEhD8P/L7BnLuHwEuoB1F+P5JwGvEuLqHkK8EuQ9LoX+F2L7R8H+IgT/CkOxM0SpB2K1KwDvKxRzSiPtJhK9RzB7DzM',
    'Sidingba':
        'BBVy93Qui41BhQhT9L1GjZ3F3PxIhDhIjOxK5L3OnB5P0DlTnExUyC7Sqc+PkJnD2M8H2K+c8L4HkRsW+GoO3LwZgOiW',
    'Sirijangha':
        'BBqBy93Qui41B6BtG/NhW4LvZ9GnOjRrW7L3H1K9c1M7HjJoD/WhPiLnVwHyD4LpS4OwFmUNmF0JwM1CsSqHgGkMtCiM0TuUmFmMmJ3BsZ0iBiD8MmQ4X6C+YsPgM0byHyGsRmU6ZhHgEzPrG7MvPvV5D3M7R9jBnQzMyB5IzKtML7MuO',
    'Yangwarak':
        'BBOsp2Qqvy1BrJ7D3LqSvHxDhLoVlKpP9BxQkFnRvB9N+HnW4K3KuRgSsY6Q9IkM',
  },
  'Terhathum': {
    'Laligurans': 'BBNmjxQqot1BBrNoHxPvPlVmLtXiShByG4GyMMmOmJ8BqTlDkQnU+BjOwQ',
    'Myanglung':
        'BBPs/yQq0t1BlgBmNlHwK9H4Y1GtNrXtQwQneoT3EkOvQoU9B8FzO2IgKkOd7I8Ob0L',
    'Aatharai':
        'BBQm8xQu6v1B6M3EwMzKkRxB2qB9XuM/QvB0hBzJ+b6B6R1F6DpR+djK6K7LjE9FrPrUvFxI9L',
    'Chhathar':
        'BBQmjxQqot1BlRye/G1MpK/FpImFrX1Z9J5W8BvPmWoB0C3EmWnEoR1P8MlDlLuXwPmVnHyP',
    'Menchhyayem': 'BBK490Qqgu1B7U6ItT1D7F5MhOpEyJ9NczL8I7OyS+GmdkX',
    'Phedap': 'BBN490Qygu1BtMgR1qB+XjRyBvM0K/MyC9LvT+H3YmHvKme9M4LVqMyRuT2D',
  },
  'Udayapur': {
    'Belaka':
        'BBbq9pQ2vj1BuE3LrMxEuQ9MlCjLkLpP6L2BO4J0S2RiQ7KqPrDrC6GsP6FiN+N5C0H2KwSb8KyPo1BjBwIpQgMzO3C3EnHxchFhkBvTxIzInEzVqHxN',
    'Chaudandigadhi':
        'BBdontQqij1BnN5OrP5FsC5GpPsDhQ8KzS1RtGvVvMmB/Q/PWxIrN3OkM1HiBlVgR8FsVhD+C9OgL5HoP8D1G2RkQoMjLgK4VZsNjH8MsWM+fuHmLhEwVsDqG',
    'Katari':
        'BBvBwsxQ2o50B9KnMxZkJlFzOhOkElItN9K2F9O2ShSnKxP8NnBhItKGYnTmK5SqBvWrW7K8EpPwDrahCjR1LlPyKlM6LlewQ7MlM4RTmIzKkN2JmCyG4VuU2NyJiTqB6Z+IoHwb+FqJxE8O3J+XgHBhTsGzEoV2M9B0OoWuK5GmU1J+BxCkLzHsCzJ0K/HK',
    'Triyuga':
        'BBkBkluQ+y+0BxKlBvXuH1M8kBlH+D3VakL/JjQnM2G1RnP7D/K6H9C+OrViDhR9F3KzZmK3NlDtU1L9MoKxMlJzJwFxJ3FtOgFnOuOlJ+LG2E7M+R+O4IxO8Y0F4KuK2MjBCkLqHkF8TobwKkL2K4rB',
    'Rautamai':
        'BBVkluQ+y+0BoDtR1K3rBrKvE9Q7c0LiC+KrH8gBwB+OjFoF9HgOiEiN8NrC4WlLyJsB8MgHE0Q6P5Q0JlJ2M3e6EpLkG',
    'Sunkoshi':
        'BBPw0wQyy90BzQ5P/GDrB7MmLxJsC3We3K+ViC4NjLiWjBkGqDpHmMrEmWjI6R9QiT',
    'Tapli':
        'BBQqjwQ0w70BjKtKgHpOrGzN2ClPwLvVyZjJyByI6OkKOuIiN2LuI2YjEyEhWkB3NkL9VhC',
    'Udayapurgadhi':
        'BBegowQyl50BvLwV1CmPsG0NxIqPzJ1DnF+H9OkF7gBvB9KsHlN5C5IrJBjL1MkB3KtK5dvJ6F/K0OwO8MZhCpUkPlJsJxPsVLoBiIyP7NiSoK+O1S+K1FmIuNiOjE',
  },
  'Bara': {
    'Jitpur Simara':
        'BBhBms2Qwg9zB5U2EjTV3K5K/LpDtJqE5SwR7SwHtK1B3G2FlbQtL6HzL5TiK1E2MnI3BhKlYtKnFzQoI/FQvO7G/IgL9GqGuJ2Z8J0RxGogByLwSoB8UoGiPxKqL2G0WI4F0S5HqD',
    'Kalaiya':
        'BBX44wQux9zB9V/D3FlOrLpL7GsFhKtFR1LhWjGtEzKyM3JmC/LuJsBhD4J4J2JsKnJ8HgCsBrK6KoDsG2TsRuRmV+H4BiK1MoI',
    'Kolhabi':
        'BBUo0xQ+lg0BhG1F/OoD3ItBzMtK1GwKHlOrK2KwBlclFrHuUnJwOqH4EhJxDnUsDtHoK0LuL5HwfyB6I8iBsBsT',
    'Mahagadhimai':
        'BBOg3uQyg+zB5WxIoExHgQ1DxMtDYzS6G5KoJ2OgExPkOqO8GrFqN4PjGsWlQzD',
    'Nijagadh':
        'BBZo0xQ+lg0BunB9VrBrT9I9dyC1MuK2B8SvH6SvRuJpEgMqD4K6KkTW6U1EM+a3R8EjJ2N5PkG/FsLhNgHzKiXB0kB/TyI1O3I/S/CxPvJ',
    'Pacharauta':
        'BBO43uQyl+zBxLiK7M9G9I3LzLP/CmJ7X1MjDhQyDjWwMqEqE6QkS2CkJ6QsNnB',
    'Simroungadh': 'BBImztQgz/zBrLpHvOyHkBhwBqNuCgDlJ0WspB3MG',
    'Aadarsha Kotwal':
        'BBOmkvQgu/zB3JiD/VxFlIuJhJ9BuB/M4MFzSxlB0HpD+I4LwKqByJmT0KxJU0T',
    'Baragadhi':
        'BBOu3vQk4/zBzH4BlRzSTzT/N+I3D/MwL/JiM4D0OjE4EgGsFyL1OyEkHoCsIuQ',
    'Bishrampur': 'BBJu3vQs16zB3L3H3L+ChCwStJrByC/U8JpbsG4MoR6R',
    'Devtal': 'BBJmgvQiu8zBvHwMvXpCrBzTxLJsCtTgIwBwL2PiWkG',
    'Karaiyamai':
        'BBQy8vQ42+zBrFxL3E/FzOkEhM3DwEjLuM/DmQ0DwGtWuD6JiLhBuOgIrDuHyDoU3EiJvOpH',
    'Parawanipur': 'BBHq6wQss7zBjW5G6GlS5L5LwIf2Q+K/DkL',
    'Pheta': 'BBI+9vQgl7zBjHoK7H/BrKoJ3J1JkFnc4L9C2MyI',
    'Prasauni': 'BBJq2wQ+k8zB9MjJlKzTpIlQgB5KkTmG5GmSoW8G9H2N',
    'Subarna': 'BBLkguQm49zB3MhFDxIxNpEwD9dwF9BkR3BsB0T0L6I0H2L/P2D',
  },
  'Dhanusha': {
    'Janakpurdham':
        'BBRskrQq8t0B/NiG0D4QgF2J/HhBxDkNzTgCxIuH3I1MnM7D2E5KzJvFIjO+Q/TsMgEwR1IyI8B',
    'Bideha':
        'BBO2jpQmzx0B9O6C1IlJyIjLiG5a9H3K4B9M6IuPsLgGyH6PmJqBzCqWlH1C3BmN',
    'Chhireshwornath':
        'BBOwssQ02v0B/jB5NXxOwGqJ8JNqB/Q+H0CClNuKuKiKwBoLuOTkM2QwEvHiJ',
    'Dhanushadham':
        'BBOwosQkwx0BvWnBiJhP9I5K8Q3NiGnR2a8C4NoF8MnD2V8ZzHsKlMjI5jBqInLoQ',
    'Ganeshman Charnath':
        'BBaulsQm0y0BqBtQtGtGmIlN2IRoLnQ6jBpImMkI0HrKtGnHqHhIqNuDwVhD7BwuB9Wo3BhTuX/KwSpLyCxG3V1JlC0KjNUlIqR1V/LpMxNZlXoI',
    'Hansapur': 'BBMkyrQ+0w0B1JRxKyNjP3BtTrJ8FtMiDpdsZvBqJyKrGgFxC8M4U0F',
    'Kamala': 'BBM+zoQ4oz0B2DtxBiMjEHoL8Q4EhD8K6Q7GkKuD8K8L5IiM9nByQvLlC',
    'Mithila':
        'BBd43vQ6lw0BvViDpNtDzJ2F9MnQzUYwHhJ1QvEUjM9KjO6flDkMpJjDzHsS+CDtGueuCyO2JoEhIqEqMgKmHwKvG0JqCwVxXmEgD5HqU1SkEvH+K/P4ElS2N',
    'Mithila Bihari': 'BBKwhrQ+pw0B7E5FqK/NpJxKrNc4G1QuPwBiCyLygBmNhGoR',
    'Nagarain': 'BBIq9oQuxu0BhEsNxflJiCngB0LpKoL6P4RW5G4H',
    'Sabaila':
        'BBPulsQm0y0BrL0CtWpFK3WtJXjP9JyE1Q+NyCyKxNoOiCqDsT/HiFwWoBlImNuGuG',
    'Shahidnagar':
        'BBS0jrQwxy0BxMgF7K7LjKtD5Q8GiD7K7Q3EInLmKsD4BlNmH2CqD/V0JsImIhG+D0IvEiPkP+JuJY',
    'Aurahi': 'BBHq7pQ62w0BhLrCpGzPiFpaoI6HgNnFhDqd',
    'Bateshwor': 'BBIo2sQ6zu0BrK5B5JhL0V9F+GxMyXiGgM6MjMqJ',
    'Dhanauji': 'BBJ8upQyqv0B9EoazMlGnIrOhEnSoIa4DrN+IgD1DqN',
    'Janak Nandini': 'BBI+zoQ4oz0BlK3S3QvC7DvI8N2BahMoI5T8N0O',
    'Laxminiya': 'BBK6hsQunu0BNqN9HzCpBgR7JOvGpJ3NjHzD3QkNlGwf+F',
    'Mukhiyapatti Musaharmiya': 'BBHsnoQirt0BzLqKjF6K/Y9iBiNDgJnDyOyG',
  },
  'Mahottari': {
    'Aurahi': 'BBK6htQ6ts0B5EnFhZxFpJ5UwNgD4JhVoO0MG0NmHK+K8c',
    'Balawa': 'BBO63rQs0s0BvVrDZuEtVpIpI+G5LtI4C5MiP4E5BpO4EzHyQqD+K4N4U4J0EmL',
    'Bardibas':
        'BBiB2ttQ64t0BwE1DrFhMG1InM/CzBrPqTyF7DhK2nBwI+UwL+C1KJhdmF7hB0NuEgZqVmVsG+NEwX2UnFsLzGxF3NkR6LgN3HoOlE/CvVyXzJpCvKwG/JlHpEpMnEiIxO1JtetCEuG/WpD',
    'Bhangaha':
        'BBR2ttQ64t0BhPrE9GyM3M8CxYzExB/TjGjM+O8C5B7N4JPlEzK2G/F+YyFKmP2P0IF2IsFiM',
    'Gaushala':
        'BBQ0ttQ6ps0BjGjTlHJFzN5H7EsWT2F3Q9I1L2C9IsS2DiOyJukB4IlF8hBKid9C2K9UvL',
    'Jaleshwor': 'BBNg+oQyus0BzKiExLvMtJ6HpM9BWhIuNhKwIlegPzBtBiQmLpExFyNiJmL',
    'Loharpatti':
        'BBPqxrQg9t0BtMBhQpMb5HjStEjN9JwGpPyI+IqI9GuVqIatE8T6EuDmM9O7CkGkM',
    'Manara Shisawa': 'BBLkkqQgzr0BvM5CP1UhOtJ7fkH0JxKkVtF+e0GqUL6BwhBpQpD',
    'Matihani': 'BBKogpQk7t0BzNH9HhOpU9TyBrL8PrH4RkN/K2NmJ0M2JqC',
    'Ram Gopalpur': 'BBM+jsQgjs0BjEkFzXtJvN9SWpOgK4B8M4L1D5VuL4ImUuChG8QvN/C',
    'Ekadara': 'BBI+2pQuur0BrFmInTxJkDnHnLnC6B9LiRxFiOuJ',
    'Mahottari': 'BBLi5pQkts0BxE8F9OhDxHrB+G/PhJlL8N6DiP1GkP4E6BqOhP3E',
    'Pipara': 'BBMozqQ0rt0BrY2HrM/DnO6LmBnL1JpClJzM+H9F6EjNkR4F0K3DrCyK',
    'Samsi': 'BBJmvsQo/q0BlVrBtL3I2D6V7M3L/J3BF/NoQSoPrI',
    'Sonama': 'BBKq4sQ8jr0BhV1RxIxKsOtZoNxC4E2H+S8JxC0J+I2L1F4Q',
  },
  'Parsa': {
    'Birgunj':
        'BBb87zQmu7zBpX3CxT/IzRyG1Z7JpGtJ/GlE1Q9KvIgBsB4JlK3DzTtXAnLuNV6I5YsSe/GyFgFqKqnB4GxIoM+HsIwRwH1EkMsM0I2GnHkQ6Lsc2H',
    'Bahudarmai': 'BBL2wxQ+o5zBpnB3G/EpKsKrHwMZpBnMwPmB3DiNyNbkEoL1IX',
    'Parsagadhi':
        'BBPu8zQim7zBrc1HjQ5L1GoHrMzI2EjMvRvH9HrIoLrM1EvN6RiB0RyHqT6FF+FmZ4S',
    'Pokhariya': 'BBKorxQk33zBzL2LlN2B7OpE4F7V2Xd3F3KoOtFoKuKxD6M',
    'Bindabasini': 'BBKsrwQqy4zBvbjF3F3NwGyB0H3QkQ9BrF2LiH2KwPV2B2L',
    'Chhipaharmai': 'BBHgwwQmn2zBhUmDmMzkB0QmC+Q6RpGgE3M/F',
    'Dhobini': 'BBHk0xQ012zBlUrDpM3FgD3U4MgGqG/D4VqC',
    'Jagarnathpur':
        'BBRi4yQuo3zBtP2E7M5KtBkY3KnB9I5IyJCyD5MnKtK6JpBuM/asOsEkIhHwIwEXqMlPlBhD8Y',
    'Jirabhawani':
        'BBN8k0Qg63zBzPhBlUhLvDyF9FjN7LzDiD7YmPmBIvN8XuFzC+NsBuMuRkI',
    'Kalikamai': 'BBIwpxQm52zBnOuF4F4KnYajIjIwI7X6WiI6H7C',
    'Pakaha Mainpur': 'BBHsowQqu3zB1J0E7R9F4G7UgKzPoL2ClI8W',
    'Paterwa Sugauli':
        'BBPyh0Qu/4zBpMHrNpHpL2BgGxKvMmBtC1M9IzJrQSuBjY8M6KmS3CoGwDmUiL0PiB',
    'Sakhuwa Prasauni':
        'BBUu+zQui6zBlZ3SG9FpT5FzRxHlIwBhFhNxNcyEhJhKjJiLrI8UsFyKzC+I0JuC2MwMlB/FyKqL1BsNqHqMI',
    'Thori':
        'BBTqm0Qul3zBtRjIrBtM0C9Nq0BhdqSzMwHjkB8GtxBqLiGoI4hB9I2GIiPtOyjClG0I9WlHhJtNxJwHH+K/QnF',
  },
  'Rautahat': {
    'Boudhimai': 'BBKy/sQwqh0B2CpO1M7LwEpNX3PwOxHkHoIlMqN2SmI8EmZ',
    'Brindaban':
        'BBV4qxQ4+k0BlK3L/JwBlmBne7F2C1NhLFtKiLvD3FxIc3NlJvB+N5UmLkMgJqOvCqNqCoIoMyRuS/IoQF6CiTgHya',
    'Chandrapur':
        'BBe4qxQ4+k0ByJtF/Gxa5ChTnQGtSgJnMxRpCnI6CvMqUgCvBlKsSnBgDxIsM7FkHmHwIzG+J0ImUjB2FnHoG4G4Q2ClMilBL4UvIwDnG6evLgDhEqM2I2RnIkBvO7I',
    'Dewahi Gonahi':
        'BBN+quQy3h0BjRe+B9G1NvDlRuH6InN0UzF4BhNoLkEqO5BiFmLjGyK5J4B',
    'Gadhimai': 'BBM42tQg3j0B/M3JW/O4H3KkOoBFmH4M7GwIiCjBiQoW4RvN8GtZpC',
    'Garuda':
        'BBPu9uQkrj0BlJ9DkBhQvIhC3M8GtGrPjJZUnLqLvHudnBoMvCxM8SmJwBb4N/B+H',
    'Gaur': 'BBH0trQq5h0B9QgL1CpLlJxCoB3OiR1H6MgK',
    'Gujara':
        'BBZi7zQ+gi0B3Q1CnG3G1FoHlUkB9JzIvI0GjHlHrM8F/CyIrSoBwBmK5SJrQzQpEtM8RxOwJgB4G9NkSpDkXtO0KyPyPwJgTgDoUmH6FmL',
    'Ishanath': 'BBLkksQ2qg0BlQmMvMxCvG4LlO6F+DrO9CjOoH9I2NrD6OtJqBwR',
    'Katahariya':
        'BBR6ovQwzh0B5N1BhB+F/OAFrI6J3BkGxK7LlPgI1G0M4KsF7ImKauI4JmQrJ1ImOqBmHpRgD',
    'Madhav Narayan':
        'BBO86tQo6h0B1JoGToL0B4H3H4KVgPgN4J/OmFnH5JrP9dyKrIiBrWqRzH2NwD',
    'Maulapur': 'BBLu6uQ6tg0BjT8LnLjEzGjM1SlI4TlR4F8EmItJwMoE5HqP6HwL',
    'Paroha': 'BBMy/sQwqh0BvD2OjMtCzDxPjKxT2FvMhP/BiD1M2FiEmWclC+S2M8L',
    'Phatuwa Bijayapur':
        'BBT0rwQowg0BlQsJtI3JlKZrF8ItJ5PhJuC5HvL6J1PqLjE4WmL2I+JuF4B2GvK0MuK4IuBgPnDiG2FjXuO',
    'Rajdevi': 'BBM63rQkni0B9KmNtJmF5E0DxIuDbpL3JrEsFtamJyC2CqLyGlGiT/C',
    'Rajpur': 'BBKqqsQquh0B7KkM5RjBqCpP3QxOoIjHwMyCmQhM9B6IkKyT',
    'Durga Bhagawati': 'BBIgxsQq7i0B/L+D7BvIxT5HoD1I2cnI+B0N8FG',
    'Yamunamai': 'BBKw3sQ8ri0BhGH9BzNxPmG7KhBqDrNiH2E+LxMyE8IyOmJ',
  },
  'Saptari': {
    'BodeBarsain':
        'BBNi+mQky70B5FlJxP8D1G7I1RvJ6LtJuS1HsH+EmG7GyYtBPkNkEubjMhC',
    'Dakneshwori':
        'BBQ+jnQ4j90BhWxBexMxJA3WjJzKhL8ExH0Hpc0RsG2G8IwWfpCwP5LwCpBsOkO6BoI2G',
    'Hanumannagar Kankalini':
        'BBUoknQ8mh1B7G0MoBgN1NiC8EyT/L5NpC/KncnSjE3IlMwCvO9lB4JnhByLsM5D4P2OuQkGlO+I2KgL3B2TmHkNoW',
    'Kanchanrup':
        'BBVo3pQk2g1B7NuEnLkUuGyDxD2V9WzBpW/RlWorBtIpMlE1Q2NhCiBpYqQxCuJ7L9DlEqQ9Q4S5ByH7I8HlBwOsHjM2H',
    'Khadak':
        'BBQmqpQsw80B7MFzdpP1S4G3LvDrHpGqDxKgP5GkMiCjEtb8DjKmN2H0VyC+SmU9EyM4FuO',
    'Rajbiraj':
        'BBPynnQ8k/0BhP1FlemJ6BkGjPLzChgBkNuEwO9J7I3JJpKibkOsCxI+K8OxEgIsJkF',
    'Saptakoshi': 'BBN81pQk9i1B7UlVyD1VtGxDoLjUsO/DVyIgRgQwMlByEkIrK+BjLqPmCkL',
    'Shambhunath':
        'BBTy1pQ2890Bnb6GnRd5CvP7KOQxIpPmBtIpJgCjOnI1GjO5BqBrOmQqG4LwD2S3G0dqPgVsFnKyM2L+M',
    'Surunga':
        'BBR6tpQsn70B9SlUzVxC7L7LiB5PmanHgSsGwX9DqNmQwKjFiR8GpEoKmFmG/IoM9R9O1E8M9LF',
    'Agnisair Krishna Sabaran':
        'BBQu3pQw7/0BtP3C7HmBxH8I9WchGpKlYxDZnLwHhGBtOrEpFgiBtE0T0DgVzJhF6GoM8c',
    'Balan-Bihul': 'BBK8tnQ2m60B3RWlG8GrLzFuC5boLTiLpBiN8KiKZhB6P',
    'Belhi Chapena':
        'BBNo3mQ6t90BrNvBnBhJzZ2BrG0L7VhI4MlrBgPwJA2F4WkJyJAdyM4MmD',
    'Bishnupur': 'BBNutlQ8t+0BqK9LlRzFyD9SiS3HuM0BoBiJsNwBU6UhbjOKqK8I4JvO+J',
    'Chhinnamasta': 'BBJutlQ8t+0BrZ2F9NxK3B5N+GvPsR3B+L0GhC4LmR0F',
    'Mahadewa': 'BBGsjnQ61/0BrQyVjU3G8Ehe4UrHuLQ',
    'Rupani':
        'BBPowpQqm+0B/U0JzTzD/mB0EyE/HhExLrKrFsIxWuN2KqPlBPyI8KN6CwPmiBtBgJjF',
    'Tilathi Koiladi':
        'BBM8+lQ0kg1BjMzIjGmO1OtQ6D3PxLrM8ChL2RlCtDoO2FwPkPM8GhK',
    'Tirahut': 'BBJoknQ8mh1BoDvEjNnW0H9WyZmEuJoNvP+O+DmEtJ8L',
  },
  'Sarlahi': {
    'Bagmati':
        'BBPkjyQ4wm0BxVNlHlClc7DpJtN6CpHxNhG4JzQrOpJkIhG6G9OkWgUgKvByU2YuRkP',
    'Balara':
        'BBRqnrQ6ik0BrT9WoB5I3LjN4LVcqLyItDiB/J2H0GiJxL8PqHhHgXa2M4IsPpIoGhJ7C4B5O',
    'Barahathawa':
        'BBX8gwQ68l0B9WzFlCyJ+FuL1H4E/DrKrRvHrIwDlJ9DyGzHnH1IqE7GzG1H4OzU0DrLyOCsTxJiQoK5G+OjIiGsOqJ3J0QyNiG',
    'Godaita': 'BBOkrtQuzl0BzetG9DzHvRZZlJjPpGgEnXiIV3B6OiJ8CmJzGgUiJSqJ8XmJ',
    'Haripur':
        'BBO8jwQstn0B6B2L9RrEvPoG9PjUsDzP4GgFsGxO0JjF1G3HmCxJ2WsF+SyOjO6G',
    'Haripurwa': 'BBKutuQqpq0BjiBxMnQtJDzHyLxE+FjJmQKyGuK1HiL0ToK',
    'Hariwan': 'BBN6jyQ81o0B9FsDpK5H/QxBxKrlBjMpE/HmHyBtb8P/HiRmEmHmCsayDhH65B',
    'Ishworpur':
        'BBXutuQqpq0B2BnLzTnK2HhLlI3WkKyDwG5FwPtB9GjLuH1P8XoOmG2cuNyTiLuc6I+P+PgEmbqMwDgR7MxL9NDlVrG/YpVziB5H',
    'Kabilashi':
        'BBPq0uQ6mn0BhUjD5L+IhLgCxBrY+MsCgFzJ5FzGkL3JmJ+DsIvDsRwH6CmHrGuO3G/E',
    'Lalbandi':
        'BBVkwyQmgs0B/JvRlbpM9P/D5I9PhLtctNxTlG1c7G/GkHhG+RsE5B1LgIlHkMqEyKslBgRyBqK6H8FrDyb0jBwF+Q5H6a',
    'Malangawa': 'BBJumtQqrn0BnSoBxM/FzBlO9OvOqB3GoM2CsMqL6X4G',
    'Basbariya': 'BBNiguQi8l0B5HlMjNyDgF1PiGnDrDhQiFhayWsJzDsL3O0U0G2HpE8GoH2I',
    'Bishnu': 'BBKu2rQs9l0BjKzC5ChLlHlQ6EtKkPqGamJwRaqJ0LlRiP',
    'Brahmapuri': 'BBLk+tQ++o0B1Rd8B1JxL9ExQ3OpGlOwajHyNqCR0LvHuL2T8T',
    'Chakraghatta': 'BBIi/tQ0+l0BjL4J6F0G/E0JjO5C/KzNwFjVkXlD',
    'Chandranagar': 'BBLg7tQgyo0BjPpNwHtLrBnUoOpB+T2CuHkNtH2P+GkLvPuBvG6F',
    'Dhanakaul': 'BBLkwtQ4jl0B7XlJtFhLHhY7GtJiItS4M6WoH6JkQ5FhFiasDiQ',
    'Kaudena': 'BBIs4rQkjm0B8epWqHgE9CsX8ImEEoLzTvGrMpL',
    'Parsa': 'BBGustQg+o0B9FkJjdwG+FjX8L/EkT6C',
    'Ramnagar': 'BBI6ysQuvk0B/P7G3IrPZ1MiH/WkNqL3BmN8GuJ',
  },
  'Siraha': {
    'Dhangadhimai':
        'BBVyzsQoq50BzNjMhcnKjDpSza3F9E4J3RpK+G7PgFjaoN1HqagIiIgHpGqGoI0EyN+Q0gBpFwQ9JpBwWlK6S9ByT3JD',
    'Golbazar':
        'BBW2nqQkv20B7GzNxH5DoRzPoa4HuCnFoPkHH5MrH7GsI1DqRkX4GyO0QwFzE6OoM+MrG8HzgBqFxN9QnIzEqGpGhI/Gpa/H',
    'Kalyanpur':
        'BBRs2rQ4nz0BvSnC1D6FsP4G1HiepImH7QnHH7J3S7MxDoE/C8OlHnHhBrSshBnQ+B/I0VlJqQgF',
    'Karjanha':
        'BBP+1sQsw00B5QjD6BnR6G1IrRlF/FrGHrSiUyB+G1GmXnIyNagMqMvJqCjMwO5Lme',
    'Lahan':
        'BBVg0oQmu50Bb5RkH7KuLgCrCvPmTzF2QmH+E3J0a4FkDqSicoKyN0LtC4HjPmJiCqU7Ma3V5StL5BvKkFpNlQvX+D',
    'Mirchaiya':
        'BBS8/sQwr20BzQvF3GxOpRjX7HmBtM9JgFtH2HherP3G2D5FoQ0BoIgHsRmF5G2I5BoR6QkD0LkPiCkR',
    'Siraha':
        'BBQizpQw900BnpBpEtCyGxM7GnC/H3M3IiBlXqN3CyB9MnF1PoTuEoH+J6JgRiS8BiBsS+KoJ',
    'Sukhipur': 'BBN2nqQkv20BpGkC9H6gB/EqCrM1MpM/DrE9QyKtKzM1FgIpS6NqCeyH4UqH',
    'Arnama': 'BBKu4pQ++10BrM3EdxH7RvC9JnPvF1H4MN4hB+G+P+JpDuQ',
    'Aurahi': 'BBJy8oQ4t20BlW1DjJ3H9DnVwBlUwUgIiOsPhIsS0M2F',
    'Bariyarpatti':
        'BBN47oQ2j30BhLhFlD6NzM3DdsMtP7KvDqD6HtiB8GkCyB7KkJ4HmW2DlFgF',
    'Bhagawanpur': 'BBK4snQ+x50BtJhHhLqBxGvGuL/SiD5P0MqEqLqM6FoN/C4M',
    'Bishnupur': 'BBG2uqQiw00BlEgetXxQ3BzIsKxb4S8M',
    'Laxmipur Patari': 'BBLm2pQu930B7SyGsCwPnNrBvKrXrKD1C9R0M4DmD5NsXiJsM2M',
    'Naraha': 'BBIwqqQiu10BmE/d8K6B4V0P8GsJI6MnPjHtCoF',
    'Nawarajpur': 'BBJq+nQ4l50BlGnSpLpMzMpEyH/V4I1CkPgPCmVgN+E',
    'Sakhuwa Nankarkatti':
        'BBMg0oQmu50BrU8HnPJElIuKBwGrJoL5Q/M9E8D3TsKEoKiZhFyI',
  },
  'Bhaktapur': {
    'Bhaktapur': 'BBEuq8Qu5k0B8Fta6DqW0G6H',
    'Changunarayan': 'BBMsm8Qq4l0BiE7eqQ2DzG5HrB7SsNrEsKmHwHqSzHqWiIkcpWEF7I',
    'Madhyapur Thimi': 'BBF2h9Q08j0B9O6F3ErHvBhakPiM',
    'Suryabinayak': 'BBIuq8Qu5k0BhE8elUpRgHnGvKxWyJrP+UlUkDsY',
  },
  'Chitwan': {
    'Bharatpur':
        'BBsBis/QoqyzB9GXlDkMzL6FrJvFhOwGhT/IvEvQhNrFzjBiItBvGhZkE9M1LoC9J1IxHmG9IC3OnHvJgHzRxK/SmIrQ3BjmB8HnRnL1XmEpIgPkM2GqRkLgRyH6E2OkU2LkcwNyC6GsP1NsSiOmfuX3D4BsKsJiHjD6NmI7CiHxR0H5FyNsB4GwI',
    'Kalika':
        'BBX2z9Q051zB3KsLrSvGxD9QnK3G0PzRrCxR3FlFkFnK/HvU1IvEmKnK9F3NqRzFiNsFwEwQ8ImEyEqd0Q+D1CiHwH+PxKuM5LgG',
    'Khairhani':
        'BBTy28Q2o0zB7EuDvd3IhT+KlE+KjMgExDjHrC7e3HxBjB1gByF0F6J9E+KsUiGvKiG0JqEtH8T2N4U4EjFoK',
    'Madi':
        'BBYoh3Q0izzBrFqCtFlbrN5OuK3djC3UiFrLxBvPmK1dnD5Fob1LmG1ImMtC2K0I6FpFsRHzHiJXmOjIwDDyOha0uBpEiWvLkMc6N',
    'Rapti':
        'BBWus6Q4x2zBqI9X9DxckM/DmE9KiT9Kwd4I2GiJzP0RoK4GyD+QyOwCwMyICoSkF0RxQsY7N1C7StPTvWhKvI5VuLlOnD',
    'Ratnanagar':
        'BBRgi6Qg1yzBgF1KmPlGgf/EuBwG4QlEwHwPlKoK2IwEuHuT3c9FpLtLpEuHhGzJhGwK9KrU5J+E',
    'Ichchhakamana':
        'BBgB2z9Q051zB0EpX6L/FyKtMvH9P2ChHzQ9DxEpdmK6EiOvGsJwF0L5FmDjM+GYxCwNmJ4B2CwV8NoC+DsL0JkIrEuO6C+I1KsF9GuPrQYLxNhI1N9FkRxK3ExB0VhJxC/D8H',
  },
  'Dhading': {
    'Dhunibenshi':
        'BBN688Qiu+zBybkFuHkI6FzGmGiuB8D4e7JsM5I/BFtSjO9S5ZxLxGxQuCpR',
    'Nilkhantha':
        'BBT23iR0q6zB5QgK1KyS8EgOnI8ZnkB/Q/QC1KgK0DvPiDrmB5DjH8NrQ3DnJiLsE+I3P6V4DgW/GyJ1NiJgE',
    'Benighat Rorang':
        'BBe2n/Qg93zBsCsQtB8PxJ+B1YvIjBiGta2PqB6GrOkT3QtM8G7I8HvWjNvSgN1I0KuGyQrYjFzR5D3WwKlOqN8GgE7HiJyCyBzVyK4E+FjRiI2NMyN5HwOjJodqOuU',
    'Gajuri':
        'BBR2k9Qm+7zBvOvXsDtSiEtMwOxUpB5Gua1PkBhG4SoDsLqNzE0JgFgOvHgWyLoS3KxB9JtJlN+I',
    'Galchhi':
        'BBVm5/Q4o8zB9FmFpOjBkC4V/GN3I+ZhFuFhIrJwK1S1MrUpE/H7XrFjHzFsiB/YmN9I+JuJ4KyBb3O2RhO6F+HhDsmB',
    'Ganga Jamuna':
        'BBU8klRqq8zB7RXlL9OrYjLpInToJrNIzJwJ7EyI6EkF1fjCnOofwMsC0P5MsO4B+O2O6HS4R2RAoEkItV+W',
    'Jwalamukhi': 'BBM6uiR8w4zBjJgS/VgH5V3DvJpdxNnWiFlHmNrD+CxHwWzC8U4I0Lkc',
    'Khaniyabas':
        'BBNm/kRm0+zBnTzHhG1gB3S7MvG1QyC1e0YgLmL+O2ScgOiTnG8IoDuKnPiW',
    'Netrawati': 'BBN+tjRq+7zB5R0I9C0Q1OT5P9NsG5T7E/N2KxS4R5GIsUkHjPsFgCgK+Z',
    'Rubi Valley':
        'BBdm/kRm0+zBoCpNoPhWnDtKiEnQzM5LkHf0ZjcyMmH4OhHgUuS6E4F2FqQgT+GuGpD6O4IwMkVOmR/JgUasM3OiKjR+ClPsMlXrH1J8JzWvGrDrMpOrM7N/C',
    'Siddhalek':
        'BBP85gRkm5zB9I4PhLrE4DoJ/F6J/gBwbnFlLwH/V/E/N+EraoFjJrCrQ2SnJ8MqCkJ4S',
    'Thakre': 'BBOoy+Qwh+zBxCgJ7P6QtHjIxbjF8IlKOrP3L5U4EtHqFlUofgFqEgI2MsUvK2S',
    'Tripurasundari':
        'BBQymjR026zB3I+I7G5EsBxhCrKzIiB7NnHzNkTmN+C6M8TjB6RkHqEuQjF2fxI5EvJ8EH0J',
  },
  'Dolakha': {
    'Bhimeshwor':
        'BBPm59Qwnw0B9JoPxS2LhJ+VtN5Lpa1H4CjLkMjR8UzWhL5V2IlM0ZvBgUySnE2GkGkR',
    'Jiri':
        'BBdss+Qu330BpObtI0KtLtE0BvGhQrVgB9OrHxI9PxH1G/IhT1FxHzIzKlhB3DxUrLnKiG9LuN/JyLuF4G8KqRwC8Mwa9B8MkS4JkBoNmJoX6LkHI4MsU+EgF8L',
    'Baitedhar': 'BBLuk8Q+oz0BnUhE3G7KzJ/BtLrPgHpO6N1Qgd+CsI4EkKmWtIgH',
    'Bigu':
        'BBqByjiRwx10B3cjPlG6B5RlkB/XtBjJkGpKpCpd/QpPhU0apTyGlKgGrZ6M5MjGlXoN7KuKqOoY8NwV6a2E+UiTpJqQtD2XhP+G8G+R4CkSxHqE6F/DkQ2F8H4QiI2JmVsQ/BoD8HtWyGzOkN9L2C1GpL9iBkNrLrD5SoE7E0G0EkSpBgO',
    'Gaurishankar':
        'BBtBss+Qu330B+B3V/E7LrU9EH3M5LjHlJnXjBnNjS3J+B7M9J9Y6LtauL1L2F4LuJ0E2TiSyHkMqdgRqKqCkJjGgYuB6RmkBmG5B0c+O/H+L4KqKlR8HG8UxTuSR6TmPkRiHlC+JyTLmLvKkF5FgP1LwDliBOhf/JTjRyB/O2K3KiElM7L9S7QyB',
    'Kalinchowk':
        'BBO429Qq9y0BrV3O3NlWiJ9VyS1L8JlP4K4D+J9I0I4DmO1DkGmX5M6M/FsZxGmK',
    'Melung':
        'BBO6k7Qknx0BxboE9JvCzbyHpB5b0Cne4K/HwNgIyJnM+KkTvEqUoQwDgF9HmFqU',
    'Shailung':
        'BBPmq7Qolx0B1HjY/E+HnQvDwEpU9KjTsU9RgKnX0E/SsPmQwQ4E2D0S5I2GiL6V7U0W',
    'Tamakoshi': 'BBM896Qy0y0BtNgKhG+LhTnVlWvGrL3QyT1RgWtD+JwCoenEjMmT/GqO',
  },
  'Kathmandu': {
    'Kathmandu': 'BBMw29Qwsj0BpJ1DvSyDlOrL+Pnc9IzE6D9KwUuB+LmCXuV6I4OvRE',
    'Budhanilkantha': 'BBH2m/Qg2j0BlsBvDlMrVwRDsE1HoJ+FkX2C',
    'Chandragiri': 'BBHs78Qyyh0BlQvPxMvBuFjS6QvU6ZyL3L0jB',
    'Dakshinkali': 'BBK+97Qy1h0BrGoG9WL1QxPuEnPkatE8D/H+OwH5BkNqGiH',
    'Gokarneshwar': 'BBMgy+Q2rl0BxGhZhNjFrI3P5HC9GpRoPAgEgGmsBwDtBkQqEoYxMkL',
    'Kageshwari Manohara': 'BBLwv+Qoml0B9M0CjDhM9P7MnTnaQhLyKC8GkT6HBsI4PiNkF',
    'Kirtipur': 'BBHm68Qo2h0B1G8JnLvBjKtJ2HpJlHpKwVsH',
    'Nagarjun': 'BBJu59Qwgi0B1B1HncnIuHtGiJnY6KrDgG+KGuSgIgC',
    'Shankharapur': 'BBMsw9Q0wk0BiPmMkDiM+MzCgH6VuDsWpRkU3FfB/PrQxLhIjc0HpW',
    'Tarakeshwar': 'BBI649Q6mi0BmM9YgK3LqE8J2TwUqB6RlQtEhMvD',
    'Tokha': 'BBIyk/Q+9i0BjX1CvM3B9JnLsIjD2MXiMwDmQuE',
  },
  'Kavrepalanchok': {
    'Banepa': 'BBMo58Qsln0BpI3NvFuLzG1J/KqD3MxLrKvb4IhEsG3MqTqT6WkJxFmV',
    'Dhulikhel':
        'BBQ8h7Q8no0BpP7apNvK6OkEgJhK4IuD+GlPiN8LgLpD0G2JuJuDpOkGhG+JjM9B3HyFuBkT',
    'Mandan Deupur':
        'BBRgq8Qy2p0B5CnI8M3OtKlCoLvRuO3U/JzR9ChPoF5KuQ9B4W8LpG2TwCmVzJ8FtJqTmByG7M8P',
    'Namobuddha':
        'BBPy36Qm4p0BtFjD9VkR/O9F0O3ZjE/ExKqHItcf5OuPzNqFxPuR0MqP8a/LiOuO2N',
    'Panauti':
        'BBW6x7Q6kl0BrG4M3IiE4MmXpJkJJiK3ItD/IiK9SnG9B6E3J3QgYlRxQvQ7DlYyIjUsJzPiGiJqSW5F4LyIgJyIvJyK+U',
    'Panchkhal':
        'BBR0p8Qs9o0BvJyUvUoLlT6QpC/SmOrXtO1NgMhOmMuFtBjT4HxFkM+BiG9JoQxK0MkQvEkMhUwW',
    'Bethanchowk':
        'BBQm/5Qmln0BvIuOpIhG7JnLrOxHJzWmGtM9PxMvKzXkBpQqOkSocuE+NoF2B4TyQwQ/XmR',
    'Bhumlu':
        'BBQgq8Qy2p0BpH8HqPgS1FmVcobrI6FtMtEjF3Q7POjG7V5LzMmanSwUnLwJxUuKmC7M4O',
    'Chauri Deurali':
        'BBR2j5Q03r0B2KjC8RpL7C7D+K/TkJ7C6L0MkG8V8PNoJ+VlK+LiEgJpMoL/UrRzH1O3MqD/RhG',
    'Khanikhola':
        'BBQk24Q46m0B1KyFOwMjU/Frb/QpK1KoEzVhDnF0OrMuE9JO3O8IpGuNmBgPilB+PyMlGuM',
    'Mahabharat':
        'BBW2p3Qskq0B7NxJxNhD1LiFG9OnHjS4K7J3DxHrD7nB6KlQFhSwIVF0LqK2KsbgRkUgGhO+NyJwMZ4MlBoGrB8Z1OuD',
    'Roshi':
        'BBXmt5Qogq0B5MyGlSoYpRqR/Y9HyItc3CzH0L5M2OtDsB7ZmBnGa3MxJvMsOtOX/L2N/EoVoSsI8HtNsOiEyIHucyKpHkEgF',
    'Temal':
        'BBPux6Quvq0BjJ8C9KgU8C8DvtB2XnLhDzC0H1HvLqD/LoXld0I9K0NzGmOgG+VjRqGoI',
  },
  'Lalitpur': {
    'Lalitpur': 'BBL6u8Q67i0B5LvF7MiLlIhNiDxN/K3JyRlB8FpG6KkJqHpD8MuJ',
    'Godawari':
        'BBSwm7Qmnk0BlDzGpSVzLjW8CpP5DrO5IsEM7QnFtPmLgE8HnS6WyZgL2GuHoOyBqH4CuN/G8CDoM',
    'Mahalaxmi': 'BBKwm7Qmnk0B4J9SEnMqNjHqFxKoJJe0Q9UmUlSwaxI/I',
    'Bagmati':
        'BBYg85Qwli0B5L6FvHrGtJuC4DuS/ML9D0azMzF5K8DtEuNlMlImKhMyInYlB5IqKnOKvP+OjNoMKoFzI4OyKsFhMiPkM7HoSlL/D',
    'Konjyosom':
        'BBP+q6Q62j0BtFyHxOQnC9QvF5JlZ1KgNM3DtSuJtCwHsG6L5FL+K6IrE6DsO7CqP',
    'Mahankal':
        'BBRuq3Qw4j0B4LoHuEtN6K7D0M0FVpWoGpCyX2IwF6JoC+Q0KyHhE0PnQ2DnctEpOjShT2BtF6F',
  },
  'Makwanpur': {
    'Hetauda':
        'BBfyv5Qg87zBlDmFzVErB4QlMmK7a2RsD2GvK6RLiVZ0I0B8Nxc4HlBtaxRpE7F7TsI5G4R7EgD9S/H1gB6HpD3FxNsD5SqPbwZ8GkSvRoGlZkTsFxEkLoLsE7C2L6OiP',
    'Thaha':
        'BBVur8Qolg0BlN5J1QpGmD5SxM5IhPrC6BnW0I3I0N9kB4J2FiGhQsKtM2TxLuK6OrG0Y3EuH4L6UNsP9UmVtCqR0GuQ',
    'Bagmati':
        'BBiBwuzQ46j0BsO+CwF9HgNa2KnmB2H9QwXhH+R1C4BqSoJsM2IF+W6LzByLvM4SrB2btE+JvL8JvL3EtG3M/GJ1JxRrXoM9I6ZhMgG3SH8BqIlSsB8CnJjJhE/HqF7FvLiEpMwL/CoG5e',
    'Bakaiya':
        'BBjBwo4Qwoh0BxGsejMiZ9W5L1IGnJrM3BpS9R2CvXiH1H+Q1KomB/MZvF+HlP3DmB9TgN7gB/CjdoL5FCzkB0KhXiN/GgGrL+OtFsJ0D7B2IyRqEtBwRuIkW+QiFqStJPjKoK7D0EuKgRyCzH6X',
    'Bhimphedi':
        'BBfk16Qk3+zB7FW9MigBzCudpKwM3OxKnF0InMJzM+IsDjP4K1iB+LwCqI9TH3UnJ1KxKuB+E5UrV5J6CrMmMlKsB3Q0VDmDlF+SwE1BwK+H4LwSvKuN0IxBmPxHiUzI4I',
    'Indrasarowar':
        'BBQ465Q41g0B+EN0Ctd+MhgB6HhBqO0IsL+ClD6S2QqGmN6JpKwR3OxG7DgIjauER4KnSzJ',
    'Kailash':
        'BBXi78Q6w7zB1TyLrKuMhGiQpN5CrO5JvSwK9H3L2BvK9SvE6ItZkGrErBlMgK/R0OjHgO8I+CjH6UlC8J+KsI/H8R2PhGmJrDuS',
    'Makawanpurgadhi':
        'BBXwz4Qyhg0B/QxCzEtKnK8DQkKpSuJ9QhFzD3MsalIzB7NazIMhVwK5RrD1GyWnOwB+IsV6J9E6UyKtBoJ2KI4UpI+T9LvC',
    'Manahari':
        'BBcqh5Q6k6zBjTrFnGmZjSwRvZ7GhPauBnN8Txd2B9QoI3EyCpVuN3L6P2OyaiHkL9KwIHQtPkF9S6LrNQxLsKkL4Q4CnDwPtSwepLhD7M4OjLkS1GuD',
    'Raksirang':
        'BBa4t8Qs75zBrIgI7J9K5UmC9CkH/N7IzOkH/JgSsBmMxK8Q5OhP8C1LnLrEkLhhB2GtDkLjS8M3OqLiDuSveoDvPoT9KiKwIUwW8SuP3J+EkNwS',
  },
  'Nuwakot': {
    'Belkotgadhi':
        'BBS8vgRmkg0BzP1D9VqB3GvLjTvBvGrJtDxW6Q5Y4I9ZgHOjC3ViUoE+H6H4D6SX6QnBmUsFoOgO4I',
    'Bidur':
        'BBX2wiR21/zBzD4EfyZ/NhEpExLhI1BPjKzNlIhG4EtHtN/N3IrFnOoBlUB3P6V+T6LayK5VqIuH0PWpI0T8D6L4InG2G4c',
    'Dupcheshwor':
        'BBRoniR+xl0Brd4D/WnIG3UjEhJ8I5a+M/L6MoG8K7DqTM6FqEjEwhBwKoJwL3BZgL/H+EtGnI',
    'Kakani': 'BBO28/Qmzh0BlRiHGjH5QExHnHvHnpB0E9NkTwB4GwL+VpBqPyDhDsVzI0QxL8B',
    'Kispang':
        'BBP2wiR21/zBqC9LxEpVwI9B2LhNwB5UmLLyWkHiGmVkJgFvEqINqVnchXzFyExGud',
    'Likhu': 'BBM2xhR2ig0BxQwSkCmUpOpBtLuPlRxLyL7B0IzQ+BlTwJ7X0LgC0NmI',
    'Meghang':
        'BBU8lkRs39zBxWjHlLMvB6U1LiN1GnGhJyHvHrMqIzTzPVpItHjD3gB8LkE2EhFgN+M2OU+CzQwP1EwH4c4S8M',
    'Panchakanya': 'BBK+qhRmoj0BtVmH8CzVtTb4BlcoOzUqOqByFgNlC4NuEiJ',
    'Shivapuri':
        'BBUw1gRsvj0BqCuF7I6akEiJfiRzHmBtM1LrQ/CmBvcuHpDjHvIqG/RpJ5C1CpZiCxLmRhH6MqErF0Ra4PuTc',
    'Suryagadhi': 'BBLqnhR6uh0BlGzZyQvSiI2BqEyLgOiE5F2doLwI6CkMnXzBoB5Z',
    'Tadi': 'BBMi3iR6tj0BzazCvRWE1etEhJWpVgX9DnB6ZoX0BL0JmPuM0EsP',
    'Tarakeshwar': 'BBKiwhR2r9zBxK6V5LZ/UtR3DrW1N9KsL9E+E7KgRBsY8M',
  },
  'Ramechhap': {
    'Manthali':
        'BBb8z4Qs8x0BjU5E/LvK3NwTsCsQzIuK7c5HxI/L4G9JpCnN4S3N1GtKjQnJvKhLgO/PlBrI2JJmOsJgE+T0RrQiM/O0JyG5BoM2R9BqV8P/C4KEgf',
    'Ramechhap':
        'BBXu62Qoi00BhiBxEnFiH9TsHtVtWYpI/B5VjG/CgT3YzCnMwOlL7BpM6QhUwK+KkQoJ2GuK3S4NqCoN3G+JyIgM4jBqE7GiUuF4K',
    'Doramba':
        'BBR6k5Q0lw0B9OzEkDtM2LrTvB5e2NvE6C3P9EjSoVlGuLxN0FgOgVsR7EqZ/JoXnV4S1IuL7U5H',
    'Gokulganga':
        'BBgBmq9Q4830B/IjK7OYhFvO5I/DzS6DzHnInE9PvLrDjJ5OzHzSnGzEhD5YtO5OrMehcjNrFtFqCnQyQxVkK4KmWwGkRgUqNwL4DyU0KmhByH0IiT2F2GgJ+PyHsHyIf+OiQsV',
    'Khandadevi':
        'BBV814Qghw0BvXhF6BnMzJxGhMgPzRsQhB9MnQlS2L/B6KrLrF5HuPpNqH5coNte6K5MuD4IvKwfoTuTgQ2IgBge1LsT',
    'Likhu':
        'BBRun4Qq600BpW1J1VvO4JtLtF3K0I/arCrQ4NvTgMwK8TwEsD+HxQyVpCoQ8X0PoR2CjGiLnQsM',
    'Sunapati':
        'BBOmj5Qsiu0BvP7HnTtTwKvf6H1F+QtKgLsNgSiG4MpDpDmJ5SwLxIH+EkS5C4P',
    'Umakunda':
        'BBtBun4Qq600BuP3GoQrMyHlM2RoPiD6YoG0E0H0SkJ6OwLsDoE+P0HoI0S5D6IgEiFwO8OXoG2ImO8FuIzKoR0BoH2F8QxB8L+ShEmM1K4KxBgPmDqW1E+M9U/B9JyFpDlG/XtH5F1GxTtBtMrHrG/LxQhJkCnOnE5V5LvKxOha/arN/CrKrMpI1SxU',
  },
  'Rasuwa': {
    'Aamachhodingmo':
        'BBX8voRyvh0B3SiRjfoJhHuWzJtF7MtQ1FwFriBxnBxCpL2LlNmR+EoS3KhDjJ0Z6D2J7JmXsHmPrMkR9C4OhKzEgO2J0N7NuXxOqI',
    'Gosaikunda':
        'BB4B4zjRi8j0B6L/GyI5Q0BrSrK1ZtBlU4TvQ2G8UsiBynB2FvF8MuQ0JuFiHtWkfnJ4N9P8EsLmKqdzJqFjGoS8S6VsL8BmG0a7BqejP6iBZqTngB4JuLyRsR+OuIrEiUgIfqMiWvBwCqRhIgI/LxB5V0J1RvC1fuJxbugBzNzNS9R9H3WjH/mBnN3L2B3J8PpJ7C/KoJtSPtNpG7DpD1OrIjIxUVD3IjKjT/R1V',
    'Kalika': 'BBN+9jRgkh0BnVxOrMmF5I1HewLrJNyBnd+OzC6LqP6HpP+OiJwI3BiLiO',
    'Naukunda':
        'BBQ4zjRi8j0BtQlZ1LtNjGnbnLvI6E1TsJOdvL6I2HsMlF2UoNgF8K/C0KsK2ZzBsSxI6Q',
    'Uttargaya':
        'BBV61kRi9g0BvLnVlMT9OhJ5HqP5LpP9O0C+DhLkXuEyGtd0FxEociXOpVwEpI+JmCqG4O8NgDqOsMuDmYnS4KlR9E',
  },
  'Sindhuli': {
    'Dudhouli':
        'BBiBivxQw110B1F+PCiT9X/G7O4JpJyEvb9F9InHpB5ZxJhT3I/CzH5LoHtBgLvSiTtX+Wn3BQtbsHFoF+NwVvT6D4IwJXiC2SnIS3EwKA4TzHqFzKwZ4GiTwSxG0JgRwQ+HCkPhFmR',
    'Kamalamai':
        'BBtB611Q26t0BnJkTM0W7FuB5TpM1GyUnIiEhK1FsCgO7JqZ9L4S1IhKkCzHzHhRhT5OpW+TlHlMxE8RvN2E/SqTnL7PhB9Y6D/MmS1NgQ3EwH9K2SjEyPxiB5L/M4NjR0GyFoFrLxE9GiFtN6UgHgDzEuTtDsN8H0FtGyW6IzBuLvNyH2B4V6LwI+OhI',
    'Ghyanglekha':
        'BBV8j3Quor0B3VomBxE+NtLgYpIiGiB7T9OiI5LvI1B3VwNxH0BtLpH/D6Izb6IxW9CzSwKtEkHuM2LhFyNiD8NyJ4C0H',
    'Golanjor':
        'BBY0o0Qgnz0B1OgPzHtM/SxRoKvOxIhN4D/PmEvP6JjJ8JpZrC/NiK2FoIhE2GxU6TqMuHvK6IgH8GwR5emkB8BqMvOmL0CoM/S4YkGgD',
    'Hariharpurgaghi':
        'BBfki2Qs7n0B9PvB7ViGpHzE1WkDGsYpPvH1NoLrLxFzRsCzD1JiH55BlF5E6DnUiKsEuNzMkJiE7CoJmSrB7BpI4SIiM/F+I5ZsXnM2JyRgHK8RoZ9HmOzIsImEmG5KmQ',
    'Marin':
        'BBbi+1Q2yp0BjNkC+C0S5IyW5I0bnP5EzFuGrN7HtTuD/C0E5U/GoIlP6H5avF9Q5ajiB0RrCsLyF2NnLqPwHFrY2WjDqH0E8VhGsPe2EiX3K8JoHkS',
    'Phikkal':
        'BBVivxQw110B+HpEwFldyFiC+PzOQrPmNwEiGpJmU4C2O/O8BsGjL8XsKmXjOgfvB2P5QuC/F8V/JkDnWtK+BzOnV1M',
    'Sunkoshi':
        'BBPg91Qwrv0BvOjQ9BxNgdlxByE9N4VnmBgZ+HKyK2HwLlImFnNuepH6ctPqNsF6H5KsL',
    'Tinpatan':
        'BBdszzQkzz0BzNEhGqJlNvEPsP9P0O5I/K3NjCzJ/QvSyG3GhT0KvZ0HpFA3T4EvKoIRhC1SvJYmHnNyE7RmHmMqW9TiT6O0HiRwFoQ3EqXyIiNnKwOgTyR',
  },
  'Sindhupalchok': {
    'Bahrabise':
        'BBZwx/Q23v0BvM2KjQ0DqFvchHhLoBvYtCjT/IrIbjPkJf0IvKmQ5FicuLwBhIsKciIvIuNoFrDsNtP8E/M2V/LLzKoS9Jb0C2Q8FsD',
    'Chautara Sangachowkgadhi':
        'BBQgw/Qsmr0B3T7ExQ8B3K2HtSMtb9d7EYvL5PmhBhWsa6Ekc1B0I3D+KgGiQdiHiIlOkN',
    'Melamchi':
        'BBVg9/Q26o0BhR5evK6I5EpY1IX9U0SI9esJoHqRjU5I7kB8LhEkJtK8XGuM2L6M8DzV2E+ImbOkOyQ6U1P+K1K6O',
    'Balephi': 'BBOsn/Q4rs0BxNiEzIwKjJgB9EkEG7ShFnQrI/P6V9IyQ7B6Y+FyCkJ/SHrDqT',
    'Bhotekoshi':
        'BBawx/Q23v0B9B1f7FrDzC1Q+Jc0KnSgMMgN1VuP7E8E1MsP0W8LPmdqMqI9C0I0KkLyCxCuI3PiNrO8XpI2C1MxL9PlHnTmiBvH4mBvI7KnY7N',
    'Helambu':
        'BBey7gR0xn0BxQ5UNjO9IlbkX5EkRgHkf5CqO0CyXmGqQzL4MrV+HGkKkTE4IyUWsIkIqD2OlK+S3PmF9JlDrQ6EvMqBjL3FnLiG1OvBzE4G5RwGyBiP7KNpThR',
    'Indrawoti':
        'BBQilgR80p0BhHhIhQe9K/FzI4Djc2Bra5EiI3QuJpT+GnC0XtW2IY6EqYwK5I0K+P2Hwb',
    'Jugal':
        'BBrBu9jRs4t0BjLxCzIzKpI+CldpM7LQhIhQnWvMhIwIrKbvBiIhctL3IrGsDpTgTIzHlK8GrkBmMjM2NwG2SkB6L6MgVoDqF5D6L8HyX7DiOlMmYzG+K2IoHtJ2Y5KyDuT+H4WR+R4NwN8DsKlLoIJ2LzK4BlPmN9LtBlJwR/MkDtIjE',
    'Lisankhu Pakhar':
        'BBO6j9Qouu0BxW4BxDjNvQ3ErOrQyLrRhE/I2MvQmO/B+IqDuJgVkTgC8ImLrV8Q',
    'Panchpokhari Thangpal':
        'BBmBi+lRsvp0B1Y6KnHuJ9K1IlY0GhOmMxX8D5L7HpF6D/UnD5L5M1SjBpNjWtGxLmEpP2K5O2P9K+JqBqTiR8KOxBhP6RvG0E3G2OwBoLhGkL4FwMpBsQ5E+JmD4PlFmK9SqG8DQuNnJuS8CgL7PqJ1B4JoN4L',
    'Sunkoshi': 'BBLkj+Qg/s0BjKgFpG5IjT/BtJ/U9IpDbnb4GjYub+d4P8QiFoQ',
    'Tripurasundari':
        'BBO80+Qgmw0BhHzD9J+I1K/DyDtOjGjRoE1GhX5SsC/W+cnY6O6TuCkTnBwYiHiL',
  },
  'Baglung': {
    'Baglung':
        'BBSivmR23hzBqLzOgLxJlInIxEtcgK7C+DiJsQ5ImCzGkH+PiGjDgHvM2S2GmCkKrM4Y7X6EvR2jBpK2E',
    'Dhorpatan':
        'BBdi/rRmi4yB5buF1OlDjQuDNoUqLqFjD2MpHyCxFgbkDwInM6MvIxP7KtkBsD7KrKlFtE/NwQpNqGtVsHuDoLjIqPxZka5XuDrIyRjHmHqMpHuVUuN8IyH9ByX',
    'Galkot':
        'BBdg3nRio+yB5WyRxE8JhSjBkCxXnD5P+EzEhC5V9ItN4RtN9BpUsF9NjD3MoJsC0DwWoHmG8K1C6SpNP5KuQnFkL6OwOyFpOqQ5ImBrVwTuC8L1J2JyF4MlNkK',
    'Jaimini':
        'BBRivmR23hzBtNzFtPGzJ3FtHvP/StK+IlQoTpEqF1MkRBmL3P2OsGgIgQ/J8CyEucmIoI/KyJ',
    'Badigad':
        'BBZqvpRmp7yB/N1EjL5OtQoFQ6K5SqN7K2CnHlGzDvWtM7K0Q5N6EnLye7e9HvKgIxHjM3MuD9ZwHmBuT6jBhGkHqKqTsKmFrD8K8KukBwIyP',
    'Bareng':
        'BBPwrmRsi/yB3K+OjRCpF2MrFtO6FvQ5HtKuK3GuBtMxE9Vua7U0G8JiC6V9E0EoD6P',
    'Kathekhola':
        'BBPw5oRwx/yBlMM/GwMhGkDjH9PlC0GrQ6I9LhZyFpOyWtRiQhCuQsK+JlCyF+L5FmS',
    'Nisikhola':
        'BBagnsR8rzyBnGsO+DqW/G2LvDuQvMiBtDsIja6XpPyZnLkIrHtDpGuVvQqNGtMvRriBiT/RuJzEsJ7jB2QhPQ5PgP5CmL/IcvMqThB6LzRuOlE',
    'Tamankhola':
        'BBU2hqRox6yBpC/JwFxWqHxCkD1MpLpFOnUkQtD2OmD4a/F4EkGiPCkByQoK6ThL6V9BwMrVoQnKjRpQ0O1O1I',
    'Tarakhola':
        'BBSkkpRsx+yB7MbtQrK5P+BxCxMmNjKxF3M2J1JtC7LsVvT8VjLkI9PwNmYPyNzJmJsB0UnKoInHsL',
  },
  'Gorkha': {
    'Gorkha':
        'BBU+3iRmg2zB6CvH/KlPxTiBuDnWsC1P9I9R7XvLqH3DlD7LmP5biNwQ1BoYsGoKkQiGkcuY6I4b1EsHrB8X3KxC',
    'Palungtar':
        'BBRkzkRyzyzB7E2GrDyV7P4DvPwOjVnNjQhGrGnK2BnYnL/PgIveqP9C6QgX8dgGuCwJgK4DkL9F',
    'Aarughat':
        'BBW6xmR2z7zBjcpLlK8BR3R1O5H3B9O6MrOrCzP9qBlQvCtGSrlByEjE4XiH2J2PgbNuE+NwDoZvDgSsJgIF0PwP4TmCkJ',
    'Ajirkot':
        'BBU28pRo92zB3JkDvc7DnR7F7GiH1PqCn0B7VpazV6GnNoQ5EkIxS0I0CmTwRyQtE2V0L8LlDkSsF2SiJ0L6PlE+I',
    'Bhimsen':
        'BBR08jR0j3zBxEkERslB1Z+B9C5MpTvNlElOpMnEkVlO8BxK8JrJySwF4KyCsB7XkLXe4OjMihB',
    'Chumanubri':
        'BBmCy5rRmj+zB0DvEkEhfUlb9WiC9M5C5GgJtV5WnM1lB/KpEkNpO6FhSmE1YPteiG/HrJzFtExX8NvUiGAoUpSwQrKoEzT6P9JmGvLuO2DiZ/G4CtHySc6Y/EgO9F+B5G2P9E8MoEoCvL8L1K0KgF0IoO/DsGoGiUzKmJakiB3NoPrTgL/H+WrVrG7JgT9G0iBnY2vBqHwH8D+Z4D6VhJoC4IoYyHlBoTuOsUwagIyE5G0NsJ8VhaiavC0T7I+FnNtF/E3J3RmLvW5DTjM3V7FlH9GqBlN',
    'Dharche':
        'BBpBy5rRmj+zBxIoJhXsB7FoF9PvCvPhINlRvMjV5O3ItGqD/S9G1FpQ5E3F/TtSjPsGyGhMlCjJvP3TGzPrJ/HwD/RhF/UqM5KgR1BuFlHobxBsiBpOonBRrCsMQuelE2Y5FiSjNqOgLqEoM2lBuV6W6G/I+M6C+WhCTmbjEif',
    'Gandaki':
        'BBOwuhR692zBvW0C9CyHlNsD5S0NlM2D4B5KpOtUkJndwL7O2ML+GtP2TsGkPoS',
    'Shahid Lakhan':
        'BBV+3iRmg2zB7JsJ7ByKvXiOvJpU5D3TjPnS3NrI+BpMsEtOzJjI9DrLwH9IkU9BoPmK+KkC+I+RrC2PtDoWyThBgLmP',
    'Siranchowk':
        'BBOiglRw01zBjlB5LtItbtGrI8C7IiMtI8P3DsDxV8E1G6HqT+O4IsVogBjIySnQ6E',
    'Sulikot':
        'BBVw9lR8n4zBtE9N/aO1J1P5dnLkMhhB7FrUwnBmMiW+To0B8V2PpC8GhHoR8Fwc8D4JjDmBwJxhB6BriBqOnbyBtFmH/Q2B',
  },
  'Kaski': {
    'Pokhara':
        'BBlB6opR2/ozB/QgIxMySrQE5WjH+D8d3H6G9HqVvOkB7IlQpQlFhK8KvF5NvUvW0DrMmOtX8OlGoI7N3ChMsDpTmPhEqQtUL5VoLrLlBjNyLvLgX4XamOpG2NwZqCxD2O+F4KzB6G+HyO4KoEF6N8H2K',
    'Annapurna':
        'BBmB2zuR0vnzB1XoE5PxTlU/HzQ5L/MnQnGgL9T5NzShHjfVlE7HhQhBzLuV2C4K7UWqG1NZlO5CvWoI3VwG0FmF/HmK+HyLtRyN9M6Q3EgOhLjDykBuF7HsLjJ8K4CqPqL0KqKuY+V6IuNwT3MoQsB4OyoBjEqI',
    'Machhapuchchhre':
        'BBjBystRqpqzBlJtFhIuFptB9W/DqEpZgClKyErPnUlMnKiGnH7H1KG5N3KnE9HxO0B5G9F3KyD1OpH3N0LtViQiBmE8HkfW0SiH+T6NoG/KgNoQ0Q6LmUgI6PyTqXlDgD2M/MkQ2B+OjJ8KjGyS',
    'Madi':
        'BBhB00mRgtszBHje8L9W4H5G9D7d6WkHsQDyMxSgR/HqOqJsPoUmKxEqZ/BgEpEqtB+WiItFyJ4FG6fnRyQvD6NzKsCvFswB3FiHlMjHxHjNhKT3DhI3T9L/PqDlOnI5chLlQkPvhBL',
    'Rupa':
        'BBQ00mRgtszBxH4PpFrD3TwJtFnG9S2GrE9KwBrhB0FxIArPmI6EiK7KqQmF8ImQgI5BiE6S',
  },
  'Lamjung': {
    'Bensi Shahar':
        'BBb4roR+kxzBrIarWrSpC3J9MsJiBuS2LrE5FuKnUkHpL1EsCpJnMpPiMpC4DtO/E3FqIrX5CxIuN/DzFxTmI1E+MyQoH0S2IzI4MuYjIwDsL2L6FmR',
    'Madhya Nepal':
        'BBRy7mR0iuzBvOUvB4WzHkC/MpHjC2K1QjD5Wt3BohBpIuFoG4TvJqFsD6JvRiJgPrFkMmC0OsGkF',
    'Rainas': 'BBMsnlRqtzzBtMtGhIjSgBzVjL+F/J3DmWtPuMpQ+QwGiDqgB8IgPG6O',
    'Sundarbazar':
        'BBT6imR+pxzB1fhHgKxXL7W7E1X+M4CkC1KgNqH0HjCwB3WqGiE0FyTtNgE6CyIpIsXgF4F3DuOhMqCoMqP',
    'Dordi':
        'BBlBwmpRiw1zBcpP1KtNhYjSvPtHvHjKjUtClIgE7B9W8GzGsCxU7PHtRsMrG/aiCnJyN0C6PiJoUjH6FtK1LsEhBtS+MrJqC4JsWsSsIZiLoMqQqdByOwR2NyGsM+fuJ0N6UuF0IvQsKnUqS3PyLzL5P',
    'Dudhapokhari':
        'BBXwmpRiw1zBpZhI7LmD1VzLxQuElTvR5HvB7N/U5K1OiXjHF5OjGtL2QjN8PIrCyU7G0G8B+WmI/DkUuCwHkKwPuHiYkS2KuN',
    'Kwhola Sothar':
        'BBYg6nR89uzBnK+HnHzS9MxQyHvIrGjFlCzOsDrQ4W8DqN/BmQjP6ciLmOoIgQpD8U0OnQ6G7VyO3boK7EkFtJvQ1H4EUmX4DuK/ItH',
    'Marshyangdi':
        'BBoB4zrRiz0zBhHqCzN5U9ftJxGrMvR1NCxOpQpdhLnMwC9O5FlRrL1LkIvD9LnJ6CjSwS4H3DtKTlX2H3EuJwQ8EjF4bnK8VxOsQ5GyMgG0K4OhH6N4EiXW+c0B8OqJiL8TwEsE4LpGoMjYsSkH4ZhBkLmHuLxDsJ5P+J',
  },
  'Manang': {
    'Chame': 'BBMqisRmiuzB+FzHwFrwByIvByEwIkcoRsL6KjMkJnE6YzM4IrEtGtQvE',
    'Naraphu':
        'BBwB4u0R2nszBrFqXZkUwEkH/P0U7FsP+FkN9H0HiDoL1GkVzO/EciL9G0K9L/BlFqI7OvFwB9I/VhD7C5NpNjB5DzQ3I5WrR1E/GjXpQpVtV3GjL0CqKhQmR9QyVxDsMpaiU/UoNiBoD1PvF1S6N1ViSNkGqHgMjHqOwPuL4CP2MwI0K+G7CiNiHjEgM+EmHjKuS',
    'Nashong':
        'BBpB88xR8kxzBrLsPnKmTzK/E7L2KnCwL7MnE1P+E9B6G/N+F5YgFxSb3CuHhZgHhRxBlHtLiBjLjH3ZkYrSqGnMrE3L7TvEpJhLzB7OV9c3EhXuJvN+O0M2a8O0M3IoE5YoX3LuV4GqQqVgHkXsR2E4I6W6D0QqNkB8C6NgWiD',
    'Neshang':
        'BBoB8wyRkipzB/LkHjGpHhSO5N2VwF2SnD2PnNhBhUgVrMqaxVyDvb2cvnB3XxEvIyF1OoRxQRjgBmPtPkGxSkJ7K1B9OgNjQrChMqDzjBkEpIkXxNmUrZ0GjOkN0O+HgUzCkMkN+QkP6CsGgHmDuQ6PyFiKrCoF+NrKsF3C+R',
  },
  'Mustang': {
    'Barhagaun Muktichhetra':
        'BB5Bso3RkmhzBpJuLA2O5D6anIyQyHoMzB2N7R0YtJ4C5HsL7V3DOgS0G6NqD6VxDyQrJyExIoPvLkB3S+P7NibvJ+CzQpUgJzK4C9RsKrFnF9NhKsC5PxFlDtQ5QjKsInU+H5BuL3mByElCFvRwEvbmTzJyN0B6D3P1JpfpOiB9IjHhB/XtPtboE7MtD9S0QnEmRgBnBmKsIgFoNhE0TmSgdwf8RmIjC0KmQ+E4S3C',
    'Dalome':
        'BCkCul7Ru2jzBjWoarLsClMkM3Qma5FkT/S2a9TsI0JqN6wBieK2OjJgOjNwFnFoJrQyI1MsRuMuNrJyajVoC4DqV5JiPrPAxJnFnNuB1L7GjatG9OmBsFpXtRlSkKtS3EhH+DjMhNhH9G8CvIzKrBrS6Nhb4S9PwLjByInPsJxEyDxQpD5VzG5NN/R8V4D6HpLuJ5C8RzY0B1NxHnMoIxQ6D5aA1OyK1LuKwHiLC8IhK6H2IvBkNuJkBuC+R8OtCqFnI4M1DsRdsC+LgX2WD54E6qKAAAG',
    'Gharapjhong':
        'BBgByxxR2vmzB5RzQ0CjM9H/TjNzOnE1NqCpOtHlFsD3M/FxFpD5TsM5N6DhP6J+QkNwNoDjO6TnL8R9OoEhVoHiCIqX+IkHqOhB2Jqf5D4PxNzBlT0JvEwbGwRxEmCtL4mB9H6B',
    'Lomanthang':
        'BBrBw/3RqoszBsJxatMtN2MrRsQxIoFnJkNvFkJ/NJ1O5wBhezJpN+TrIgT1a6FjT4QlamMjMsLrCkWnaK+UiH4MkL9E8R6LvC2WiHsEoKuetFqb4IoKlKuV9IjHlHwRuH0Q5JqR8F6JjNyWxP9F3HoSe0XV2OlO/BtMtWnoB6HnDmP9MW',
    'Thasang':
        'BBe+jwRkvjzBrO3D9J/O5PtMpXzIjG1F6D/MwKthBuCrM4gB5FmGxKoU1JkOgGgWuNqPlD8Krc+E0FnE8MuPubtGrBnEiV7R+O5ToLnDkOjNvN5J9Q5DiPrM6NqD6TgGyF',
  },
  'Myagdi': {
    'Beni':
        'BBPimqRingzBnVVjPqRjLqD0LpY1IlRuHhF+DpYmTrFmH2LmKmBkDlJqG4RgGrDkFsP',
    'Annapurna':
        'BBlB0wqRu1gzBqLqFoOX8J+KqDjNsf5OweoK8OzJyIyJvKuhB5DgNkG2FqX0I6PuM+JgPwHrBqOqKpCqOoE2NzGkOlUsZlX+L1O9mBnQrBvT4M5ItNtY9VzKpKpPpL7K3CrLkJtF8HwCjsBtQ1FzN1JuKzSmJzE',
    'Dhawalagiri':
        'BByBqqwR4s/yBwF1WrHxGlV3HjWpOjbrCjMlNpO+QlSkInGmMoB8N7NlExEnIwJ5V9IpG/C3QgGpFqB5Q5XyFkWhd8KxNlKtHgDxMsL/F+BvMiL5VlDjE4PlJsMuGsBtLgUjc8TsDqSmUNqI6NyPuBrR2SmJqSmB6GkMhN4dkKgiBvCmTiSyQvB2NoHmbuL0UzFmd3GwMpPmD/VtN',
    'Malika':
        'BBWw+rRu09yBxVqFtDlKvR/B6E/M9E7H9XnF4HlNQxNxK3S4InQmPjC2O2IqQzOoKkRiHtCkKmM7KyNjWid6XxFpB6Q/FqF',
    'Mangala':
        'BBS84qR6g/yB/FsDpG3RjDmJlKlBlH1L5SuF2EvcoHrLoKnIQzQ+XoF+E8H5EgNwRgC0EwRpG4CnBoP',
    'Raghuganga':
        'BBgBqqwR4s/yBnU2JlGyK3gB6FtGwG3K7C1I6IvenKrf6OpDkN7J9K5UXpPlS+X7WjFrP2J3NoBnP+NzO4MX+IqGvJ6VyEoI8NmEnB7NoGlMmSjIqO9QkMmNkbsCkWqOmV4HsHyG',
  },
  'Nawalpur': {
    'Devchuli': 'BBMoq+QqxtzB5KmGpcpJjX+HtEhiBnEhK4IvO6UzD6MtHgUiG8JkPkFqY',
    'Gaidakot':
        'BBR08+QqvuzB3G8ItX+HyDqVsN2EK+OlK2P3cuI7F1BhOlf2NrSxPnf9GxYkX9HqcqJ4KlGqQ8M',
    'Kawasoti':
        'BBW6h8QgrszB/QlO/GjY1O5J9GwCpOrJoFtQ0J8BsS9K+KuDpCuImO4CoCmI+OckHqBtBqNyP6C+N9D2JiUpOpD5MuH5U0D',
    'Madhya Bindu':
        'BBZqx9Q2knzBlHkN0C8MzJkLvD6Q7SsGhSmU1I1BCuK9KtDrS+KzJ7BsBhKxPlY8MjNrElRzD9cgPhHmGqEoNtD2NsC0MjF0FkF0ShPqQ4E',
    'Binayi Tribeni':
        'CBeuy9Q8/mzBzb1MzSiPzFjFzMkF1NrCnNuDlGpEpJ4GtJhFtB7N1HpIwT5T1ErIsUB6CjSoK/K8JkJ+ZmEqGl2B7GpS8MsFyWxNrFmdkHwNqCmW3IkVXmQgQTA+XBI1zE6I7KsJlO0C0GuL5I0C7KrbuQtHgQxF',
    'Bulingtar':
        'BBU08+QqvuzBjCjRnQ7MuGrTjFpY7JjPmM5WiPxDsJhI6I6F6QOpEuKwB4Q0CqLDwSzGyByCuNpE8OR+Y/KqI',
    'Bungdikali':
        'BBRmggR+6qzB7Z7GrJiIhPyDqBhMvGjLoD5P8G1O9IjLmEhM+JuBuSmPkO3C4JkFzE4P6MoP9C0O',
    'Hupsekot':
        'BBb8t+Q2/qzB7MqXxN1PjBzH9N+DxP5CuBpNjHpB9ObnClIlO3CoC7S2I2BiSlU8SrGwD5Q0JjLzC7MmHjN6K+MuCyZwP0HlEiM+IkL7G2OnD6PwGkL',
  },
  'Parbat': {
    'Kushma':
        'BBS8qnRg2kzB9KuBjItShK3M2DvWsJhc0R3BwR1jBiG2M4KyW3JsJ0B4J1G8P9O7GsGyIrDuKnNRO0Z',
    'Phalebas':
        'BBQ+ymR27jzBnMiGpPhEmB9RlMnOyBxcrT5ES3SiH1JsG6M0J4FuPFyWgNmBgT9H2P1DwW',
    'Bihadi': 'BBL47kR6ohzBzQvEjI+JpTlDvHxE5FnI+OhS+F1LgO8F8ImMiUkN',
    'Jaljala': 'BBKy1pRq+hzBnnB4CpKjUClP0dhGkPpRoVW0KuOzGmVlJ0E',
    'Mahashila': 'BBLsslRw9izBpG1BzJ+OpO3TzDlWpJmHvEpNkKxU2TqBC2UsT6E',
    'Modi':
        'BBX8qnRg2kzB1DpKNzZoNSsDtKrGxI+O8G2G7PlD1GwLvO2gBduUkLuQ2FsB2G3O+L5Q4ExN+MxLuRlK9HlFgIvGzFnI4V/FgO',
    'Paiyu':
        'BBPujjRsjhzBgNaX8GgToF/FsKwEqNqJlH0DmWoDsHvNiClKjN3P5DxGzSiE/K5H3G',
  },
  'Syangja': {
    'Bhirkot':
        'BBPkqkRk1kzBpO2JhJoFlE6dpL9QxGhZerO6IhLyFtSvCpNgR9JsJ2L+KtCD6M1N4L',
    'Chapakot':
        'BBYqpiRo9lzBnH4JzIrB9EkQ1PmB2HiGlBoZ/M4FzN/M/GtJmL5U/B7ShJtK0F7P1C5H8SpU8EtMqK+H6GsQpEmPvB2FoSvCI0I4MmF',
    'Galyang':
        'BBb2kjR8hizBnKe+D2I7MnChTgR2E4MgCmBlD2KlF6VvKCpG9LvLCAvO0JhL1B1WqGpDzP9M7B1MyJrB8J3JoH8BsPtH+M9OkGgMoJgB9DiO6H4G',
    'Putalibazar':
        'BBW6mkRounzBmE1MvJlfBlLtRxC4CxQiJnFuXlN0IkJwNuEjDqHsDuU6IjLvB4dM2X6EiDrDqT4CiMnI8N3IuBrW5crDqG',
    'Walling':
        'BBa4njR86lzB1TmBhJyEiEjN3MlFHzInSwCwB1FqElPrDxKwKBmF5VmD1K/BlB1E3MiT/Q8MoC9D1IoKdoF0N4RiFlSkKwCqNxFuS5IiLdsO',
    'Aandhikhola':
        'BBRq/mRwhlzBhXtE2C+IpSuUlGzK5IkLrDtUwEzJpH7ZsKpG8BxJ+I0BnB+IqPiEoMhGuEqP+OoO',
    'Arjunchaupari':
        'BBO04lR40jzB9IzB7ByJrKqGqH8Z7OjCzIjJjJwDjJxe2N3L4FpHgIoH0J9OwS+P',
    'Biruwa':
        'BBT6mkRounzBhJmEpX1L5DmHnSjE9F1J9CrMrGqQpcjN2PlB+EjQ0IsBiDrJ+OxB4bSoI/HsJyCCmLwJmf',
    'Harinas':
        'BBTi9gRu7nzBoOlFmBnZ0UiHsGpQ+CsM+F2JoSkE6DlHqX2LnKmN8F0R9GQnKoW3DxQxJ3PrNMvNzI/X+G',
    'Kaligandaki':
        'BBP6uiR4wgzBxHoO9VuG/E1LkEzPxBxWnC/IoI5ElJpUqHzOfzM4N6NiRsOpLqXgIiR',
    'Phedikhola': 'BBM46lRkknzBtJkBL1XmDlR6WrW1C9IsQoBsJ6HvBwInLsLM6VpQuU',
  },
  'Tanahun': {
    'Bhanu':
        'BBTygiR+7wzBsLxHqL1nBwM1H+OwTgDvN8GF2D7P4RtByK4QsMjB6DqLM8WhQge7N0NpPwHxDzG7d/FjLtS',
    'Bhimad':
        'BBSigjR8pqzBhQ9C3Jsb4GwL1FkJhP/VuDnL/P3SmMrE7PrH4FvgBzOvS8ImCgY9GwN0IsNLyJ4P0FwhB',
    'Byas':
        'BBiBoolR+ovzB1LqBxK3Q3RuB1D8P7GG/CwN9OvT7OoPjLoFsBtJ3H7F7HoK1LKjOtFvKgD1H/FsGvNyRpIkC/JgNpNuOkC+CvGzKhI+BpKsSqFkQvS0JmB+M9YmgByKGkTrL4DsHsX8U0lB',
    'Shuklagandaki':
        'BBa23kR2tszBlVlHzFhI6G1MnQlGgCvLrN7E4BxH3J3JgK9QpE/LwJlOmD/M+GP7FzRuIjM8KnF+DoSsDpGoW6d/F4DlOuXzDsMwUwW1CsYzFyI',
    'Aanbu Khaireni':
        'BBV2r/QmwxzBsGgIuCpTkJ+DyMrZ+SmQ1DiIuL+IsDvP8MqJ4DgL5J+M5HiLzBiT3G8FjU+BvH+I7NnC1CvVlJ3ByE7gB',
    'Bandipur':
        'BBXygiR+7wzBvIqW5PjRrDwPtL9I2DhI9SlQxMsZ3DzMwFtO8K/KV9N+FvI2HgGwK/CkOuF2LJ8HnK4H8FrBuJwOSpGyF/F4U',
    'Devghat':
        'BBZwvgRqsvzB9FwIW+N7KgL7KkXtCqTpLhWxNrBzH6FhHyRlI8CkD5NrJhH3BrKmL/CmK1PJ9OrN1ExDpVuX9HsEzIuR8CoKzH+Q6JoKyQ',
    'Ghiring':
        'BBUs6hRulrzB3M9CnOwD1S7CU6J1KB8HhoB5MnPoE3C/C1RkDtOsGnCoD1eoK9EuLgcsM8N3FwgB8PsHlMsEgQ4S',
    'Myagde':
        'BBOu9jR4gszBhS2bzJlBjQwSrSpFqD7pBuK3Q3GvL4Jrb6RsEoG8PsN8E/BwLoQmG',
    'Rishing':
        'BBYkxgRmlvzBnKxQ1PnHClcqE7OxCtN0GxBEvSzCpLChWuFuN2KCT5J2S8CoOvD4M+C+MwR3E0HnFm0B0KiI9CwGtOjC/MqNjCgK',
  },
  'Arghakhanchi': {
    'Bhumikasthan':
        'BBYovjRuw2yBpErChRxI1CwMrHN1G2OjM+NlI7DtMsH/B7U/ExFwF3PjF9P+JzLuVuByNxL8Lrb0FiMqK+B0SzH8W6RrJkB7IyL5JsgB',
    'Sandhikharka':
        'BBZyujRyv4yBtRf9NoQhBqHpTsFsC/dxQvF3C8KvN0FnE3PsIrDrIrI8M/QsD2FuMrHmI8DkM9N2G1OsHO2CvMiRyI4E6IP2T1G+KwK+O',
    'Shitaganga':
        'BBxBsrhRyr1yBzJgMkF+PvF4PqEsSjI8OtFwEsIsIrIsDAuJtNmI1DwKvIgBhL5IhM4IkHiIzM+Q7IvCrDoIhV3HkHjMpF3ZwEpb+EjayIjE1P/QXvIuKzDkPxOkMrC7OjOwB3W/GnTsFrRxBvaoD1sBkR5Y4IuGoDiN0TkP4TsMvC2OgFqN7E8F+H8KnG6M6QgRpD2b8D8K',
    'Chhatradev':
        'BBS28hR+56yBjFvX7FpOmDrH+MxGqMBiBpH+NnQuRgBwF4JiN+F0R5JrYkdzPgCtXuN6BqFpN6KG8M',
    'Malarani':
        'BBV2wkR6y4yBxPuMhN9FvF3JuEjLvK9O2G9KQ1ToIlL6JrgB8IxLiYmErIgQgHoNrDuLjJ8EqCoP7KmCsE0OrIbpG0T',
    'Panini':
        'BBW66hRwr5yBjJ0I8FqO+G8V7QlFqBqQ1KvGzNmHpHuNvf9akDvYtEnQjHhIiM3IiL6IwIf2DvK2MnHgFsFwNzF4C7KyQwF',
  },
  'Banke': {
    'Nepalgunj':
        'BBWonlRu37xB9J1LpRSrQvE1G0G1LlFxI+DzG/IgPnGsF9HlRjNmO9YmMjB4G+F2K9CpEmRoQ4IwH+B4JiFzEiJ+JkFiEkN',
    'Kohalpur':
        'BBWmooRkn+xB5PzUxU7GxGxPnThQ9ZtIxI/MkIvIrCtKkK3GjBnLqJS9D1KydsHgF/B+BwTsQ2XoYqGmYkPxNggBjMqDqF8H',
    'Baijanath':
        'BBXghpRst8xBnY/OnYpGrQ1X9BvT/EgClbxHzC1SsJwHgL/FuC/I3TthB0N1GyOiN+C+N0UuRoE0NkN4WoHrE6I+H/DuF8VmJyH6P',
    'Duduwa':
        'BBXgpiRm38xB7I6HvI5Eid1kBwDpiB+EtKqRoNrF+H/OoG0GgJyI9D2LmF2GzGsQwEqRR2NmSxUoL3TjI5HqM7SYxHjKnJ8C+CiP',
    'Janaki':
        'BBP8tlRol7xBnMtJ0EhJ3JhFvH9BnQ3IqElR1K+C5ShF+RxegM0UkMtI8B2MwTwMsMsmB',
    'Khajura':
        'BBQ29lRkn6xB8BiL7NxE1GjXvTvM7B1MjMuI/LzUyJvU6K4LyDvI0gBjHkcs0BtCgJ/KgGrJvH',
    'Narainapur':
        'BBRgshRk6gyB3d5W7JS1BrZmLlM6RhcKnK0X5dwI6EiEtIiIsIjC8VsQkP9J2SEwN1SsTtJygB',
    'Rapti Sonari':
        'BBrBmooRkn+xBpCoJpOmNlG1C6C+NrKmY5KkDrPkdpN0P1T4MtTS1Rg3B3QqiBQyGtOqN7RjFna8DNnLkGxZvHpGE9iBxRCmE99B+EjGuJxgB2SrTDvN+J1SrQjPkC7V8N/I9ChPoJ7CyHkK8SX6HpM4TkIyUnLiF0F+ZuIoTiQyGyPyU8G',
  },
  'Bardiya': {
    'Bansgadhi':
        'CBMgvpRgn7xBoJoNhBmKqMgByClL8NQhM+WzE8VrQ1JnThEyB1J4LpRBZlnC10FmJ0HsPyB0PsVwUmLzGwb1F2K8DoNtHiExD4QoK6O1FsV9IzHlHiElIpPvJzHQnNzRnRwMnM/KpRpClM0DnN2HxBlHnOjFpR',
    'Barbardiya':
        'BBXwkpRuz3xBhCxFvUlLzPrVrPxBlJzHsHxE8D7V4UzGiC9XuHrT0GkH8ZkGmQzH6M2J2S4Q0F+X1IhD9R2JnJsWrPmKkEoMpDmK',
    'Gulariya':
        'BBT6unRqwzxB6SkM2N1FzBmOtJwPgC2LzViJjDiL3IxB5D2O3XKuBlWrLoBlKzDrBhXgFhE2M1OGwK4RN',
    'Madhuwan':
        'BBRkgqRu8zxBrQsHvTnDlK/ItQ8E5SjM6hB5dqWkBuW9OgE3F8NgIiW9CHkN+I4IvH4IpTtB7GyT',
    'Rajapur': 'BBNu9qR6iyxBlOkE3PlNkN5mC2O9M2S2Q0L+CyDuMgS0R6DgO7X6M7K7I9T+I',
    'Thakurbaba':
        'BBSyirR080xBxN3R9OhE9FrKmM1H8GxTqTuBwH3I/HpO6Y8RxJ6B4KwD8O+P6OkKwEoT3XnC1IzClU8H',
    'Badhaiyatal':
        'BBX2nkRm+3xB+H5QqWiDiO7UiMhC+I7WsZhCqC3M4IyBJmKpO0JkFqRmHoO1HyBzDoNqCmMgLqRjQmLlJrUxV/ClIpPrYiDnMoN',
    'Geruwa':
        'BBPmvuRq9yxBhWP/K1IhXhF7NlK7FiF5W1LlH0GnMhEiDnNgU1IoMmJsZ3NqNyEiW+W',
  },
  'Dang': {
    'Ghorahi':
        'BBkBq2kRmntyBrQ7PpGrfnM8OhCodnPgK5FiC7O5IpMuJ3T5Q/BzQpOiG0I7NuFjbpK7KiLlS6HriB0StqB4RiOkE7JyLkJsDpNwSgCiKyRoDyQmYzCmHsFe0QkRoFzIyajGiHqLiLtFwIhF+OmB6NrLsD',
    'Tulsipur':
        'BBiBq8lRo/pyBjRnFdzQlHrFlY0CnDxQhKxRvS/BrDqNxLjJjE8J3RhOkDvO4QvXhBhHwL1boLmHsE5HiGiLgN5T0XyemJyBDzcyD6HqUmLqZ2G0X9CyGyT7CmQ9MoHIsPhVuSJ8PpLuB',
    'Lamahi':
        'BBkBykjR45lyBvL2biBiH3QwX7EqU7Q0kB5HsiBhLmSqK8KtFkbzI8NqOhGkEwEhG6mB1etC7VpJNlVuDjO1D9NmGvRvElNiPlKwErSsDjPDxLiJdbxQgGlawNtRsF5SiGxFnI7GyN/IgU7X8LlE0UqE',
    'Babai':
        'BBRo5nRq8kyBrKLhN/J/cvB5KuHnFtR/RvTxW1LgPhpBuTR6L7Ggf0JoZmSvCsK2NgU7EsU3IyG',
    'Bangalachuli':
        'BBb46gR+1wyB8G/EwHloBxDtCiDjwB+EzVwTmQqMtJ8O6I6FhCoP/JiCndoM7OqGsfyQiPP0HhLwK/OkmBrCyU9KnNlKNpOsb9J2DsBkK5ImChMhJrB+H',
    'Dangisharan':
        'BBS4qlRk3lyBlFuNwC+LlJxBzXxe/M6ThGhLrE6HnLlH0MlVyHhN+UpuBmHR4R6QtHkOwCmXqLDgSwL',
    'Gadhawa':
        'BBdk0/QqptyBnI0FpBocoF0gBhC4YtRiaqGkExR8FFzNxB9f9J1EtBnRjNqG7LTlDrwBjQl2B+CtPrI7fkZ4CqCyJqNjBqIgJ6FhF2MyDsMpFkTdiF4KlGwR2D+N',
    'Rajpur':
        'BBmB61/Q++qyBhgB2I1MxD5FiFpI/IpNkBpCxJjZ3CiBtKgPrd+YzV4SvnBuX/f0G7N8N3NuO5hB/E1CsE3QwS9TwR3MqRrCD+iBwHqGjGyZOoLsOK/T8XxNgJoI8GhGyFrF6SvNuR/FmacyQhJeEyLrDkPvEsS',
    'Rapti':
        'BBR46gR+1wyBlPqWzDnLvO1HnDhN3ItGsC/ZnFzgBqBncoIzFkDyJuTqF2b4B2C+LvDugByDuCvHmoB',
    'Shantinagar':
        'BBR2wnRwqmyBxXiDpZ1GhV3PoU/M/RvLpLEvClXyI3NgN0MoFuR6KtHgdwBiNgKsKMrF4RkEwL',
  },
  'Gulmi': {
    'Musikot':
        'BBasimRoz8yBtE3MyBxRvD4H7aiE/EtQ+K9DJpTrH9HsHtP8DwDqQtH0MkBiblPG5Q8J8E6MzBa1QmJ+FzMwSlQoL5EoLzQ6NqGoVrF+N+BqU',
    'Resunga':
        'BBSuklRmv7yBnWnMwC5JxOrG7K0E/BjH7YrFhJ7IuXtN0P/BgP/RoRa3CmSyKC7GsJoIiLtEiJsH+H',
    'Chandrakot':
        'BBVgklRk3+yBzTiK9C9LqIlLnHlK0J3VrHlRjLqD9L5I0C7K8JzM+SzGuMyNuWlGwD3HxByR4GmQta8UyE+VtBuM9GzC',
    'Chhatrakot':
        'BBS25jRuz8yBrIiR1ItEhDvTvKI5OwFjRoGyGrNnFvQrORxD5L2GldwY8TsP2ByJqKrBgIqRlDyJwJ',
    'Dhurkot':
        'BBU+pmR8w3yBlJyM5S+J6EsJjM4FyC+KnO0FJ1FvOoB0GlN5QjRqGzTsIcrEzO8KlCpCnPkJ7EmFyiBkVtKkST',
    'Gulmi Durbar':
        'BBSk8kRqw7yB9V0LzHqMtC9IxJvJpRmDsB/HxJpKrP1B7B7SuLrKmSkC6PsGgCkH8KzEyOsGvC6JoWoM',
    'Isma':
        'BBT8jlR2k6yBpI1H8GrJxKB4DrKyN3HxC9KkM3F5ErJqSnI1B8SuTqD2IuG4N3CoE4K7J7EF6QhbmPzMjB',
    'Kali Gandaki':
        'BBUwtiR46/yBwNxJ0JuF0DpJiM9HJjJoSvOkKuT0ThK4GgI5FwQO0NpOkFzKyLjInM9RKhBmK3N8QnJfpOxQ',
    'Madane':
        'BBRkunR0z2yBxN2PxNXhJqOO3MjSUjVuK/D1Y0CzTuJiFyOxDqGpK2JpCkRqC8K7FiNoCwBuM',
    'Malika':
        'BBRwjoRs34yBlJ9FZ2Q5LPnFzI3N4C1ItGtTpDsEvdwLnGyE1LyNYyN1PwO8JtD+ZkM4M/HyH',
    'Ruru': 'BBL+qiRmr+yBlV9RhF3Q+ClMyLhBiN9I6OvFwKHiDwT2IuEzN4W',
    'Satyawoti':
        'BBSutkRo1+yBlHvHnSwOKkJhM+HzDqJzJtFvNyJ/HhRqLpX7FlH4Y9PgW5nB+L6IkLpDsHmRzJ4VoHmK',
  },
  'Kapilvastu': {
    'Banganga':
        'BBWu66Qos5yB1CpK2HzP9FpCmK9WuRUJvPmMzK6SoNnErZiKgEoWxDgL3G8PqGiBiO9EkavEqbJ6PtYuH7boDlPxEzX4G',
    'Buddhabhumi':
        'BBmB4q+Quz2yB7PpG/K4GnWyDhK/DoEsZpJlEvOvPtF9P1MyH1KxCvOjUVlKtOjFctNkPdqDhM+F2DyLvJ1CjL3I3CX7KsKxHD0K6O6FyH3MsZA8GuGuYrEmI1HgcyCtCsMgHoTvB4W8OkOjMsCjPyOtK0D',
    'Kapilvastu':
        'BBXsj7Q663yB5PhOtQ7B9I+HhTrOkJhUvK3LsEnL9MF8CzQiL8D0D9NkL1EyIwDbuNuOkFWmKwOkU2KyC2MxHuKsWlM0KKwP',
    'Krishnanagar':
        'BBPou6QwxyyBvQ5E7EgRtIiFhN7CuBnlBtDrT4DrpB2MyI6P/GgJ2EtF+P+F+O/H0Q2NG',
    'Maharajganj':
        'BBWui6Qq90yBxIvD3K+EjGjG6DrM3ImG3V7H8GhKiPvJZ9WgN2CuIhF8E/QkQwE0H+PiJ+JzDyR4I4C2CkLxLwJ9F1DpDiM',
    'Shivaraj':
        'BBX23+Q6qzyB/bxClI2HtYsE7GtGrZAxH4M5O5F9O1TnHzPyC1d0UsH8erKmO1Osb1LyGlHmQhCwLtPYodG0N8KC7C0iByBwa',
    'Bijayanagar':
        'BBV6w6Q6zxyB1NFgIzQ9F9OyFxO0QqE2L3L4TkB0OtPoPmDuLjI4L+BiUzHuBoRsHuGjIsQlQiCxGmHrb2LlO2O7esK',
    'Mayadevi':
        'BBQy96Qqj4yB/LlB/b0HzItFzX6H5KwHtE5hCqK4GgMsBwC7LmI4JC0MiTsO+I9HuQ8B6PiO',
    'Shuddhodhan':
        'BBRu66Qos5yB9QvJ/c8RnOrHhO8DvQhGtHwIhI7I8WnSyNnFWhH0X5H0IuFgczH4J+EkEoL1H0P',
    'Yasodhara':
        'BBRkn5Qo52yBnIlLvC8L/LrBjLjK1BhW4K5tB4V8H4IlG5DsM4F8FzD+NhL7D7C0Q+MGrEoLwK4L',
  },
  'Palpa': {
    'Rampur':
        'BBYohgRk0ozB7Q3K3LsDmHvL9K9gB4RjPwJ/PwB/PvQjMyM5VgP6BkBxMhGxIuT/ByMwF/Wqc2C6HzF8PiJuKgC8SlL6U6F8GhFqJ/B2a',
    'Tansen':
        'BBZmvhR6s/yBrKyI/KnBjLgV7K/F/I2HxF1FlN0KhLpYgBrSwIVmFlNsI9EqSiFuQlBwOzOyB9P+EiHgFvV0FiFjHsN2DoHpH0O4C8KyI8E',
    'Baganaskali':
        'BBSu9gRgvhzBtRuHjGrClMnT9M9GF7O2I7FyF2FgJ1H8KgGkL/UgLoBsKxIJ4GyByWjE0PqE6K7J4J',
    'Mathagadhi':
        'BBf6l/QurizB5OmJlG6MhKWnD0hB9ToE9BxPjHvNsFldxWyNtM3FmBvH8Q5SxBhUuHvGuDpP6CrF6KlIkMmKG2K2QH0F/J0M3CiOmDtCgL+M+GmMoTkGsCrTqMlI5C9HpR',
    'Nisdi':
        'BBayv9QgokzB0KB+KhJ8D0V2LW2NycvF2O6R2JjB6K1MsL+K+gBlHwL4LrD8Q4KmBiR7JvEjO4CtSlP/V/E7Fzd5K/MkFrZA9X/PUYlQ2G7L',
    'Purbakhola':
        'BBa4ugRm6jzB/K4BiGyIjByM/O5BxM6VwQkMvBgQvJgQ5LpN9JtDwF1O1Nxc1LV8BjI9GpR6C9YiKVmG5M6OlJ+I8IlC4L6C4V4K+CuFlUgZuF',
    'Rainadevi Chhahara':
        'BBb44hR+58yBtLdxSkP5T3CwGnQnNAxGjGuDvThZkF3OrBzO9GqExYnHzLS3OsRZsDnIsLuBmJrKsF4KjDwYwf+aqHtN0NlH0JmHGgWsOSoFwQ',
    'Rambha':
        'BBSu/gRm8jzB1Q/B6JlQ/YtFtFmU3K9C5C3VmC3LzJ3JsD9b+HqRkOpDge3NwCwN0P+MpGqD2B2WzJiL',
    'Ribdikot':
        'BBW6whRkp9yB/EwV9EhHxB+PvO0OrZgBzVvKhB7QvIsEoIpPvNrGwSzZjGzD+D5Q4TbtDwTyGkGoNAvGoQ6T4CySjPqGqD',
    'Tinau':
        'BBfii/Q4rgzBxN2CzFgK1QIF1KjMlK5KmI4J/c4Cpb5FnKgC7RsJvG1C3O0IpMzIhL6KzI4DrKoQqHwTnCrDmQkG0DvS0ZwNsGnIqPwIrEiB8QoJ8FrF2ElFmNvIWfsS',
  },
  'Parasi (Nawalparasi West)': {
    'Bardaghat':
        'BBVmq5QqmmzB5RvRqF5JxJ3GiClc7DlSqFvH8MS6SiM+D3MojByPkJtHkkBR3C0oB9ZlE7JjJnKgL5CkSrUC2EsIvT6T',
    'Ramgram':
        'BBS+g6Qo5izB5WehEsJnV1J+KzDwIrXlLrDkE9b6F9I8PhDwfgDoF+PrKiFrH2PsFsI3G4H4MiIHmG',
    'Sunawal':
        'BBX4r8Q61jzBjjBe1I1K5cpObvI4OsEIlG3MhI4G3HrFrIsH1PsKhF9GrG0BnS8a3DwLwQ0FZ+LySiSoCrB0M7Q6SlDkOuIiM',
    'Palhinandan': 'BBJ6w4Q85izBlR+MtJGX9Iib56B8MnCpEwamLsDvIsX',
    'Pratapapur': 'BBMwz4Q6jlzB1E2LtY/MrR0ErNzImT1pB6KsPmGrKgIwD6IzH4KqKlBiI',
    'Sarawal':
        'BBT2y4Qw2jzB7O6G/HvDlGsK5KrP0K3WY+IuJF2J1J4cuGiErJ0UtBmhBqT2HmKjJyHnjBxP9D4M5ShM7MR',
    'Susta':
        'BBR032Qw+kzBsN0IsRzEuYgN2E1LmKmHpF6J6RwRtH4N1FpO/PyFtQuHhFrQvXsCtBiUzRlJpJrR',
  },
  'Pyuthan': {
    'Pyuthan':
        'BBYmxmR8uxyB5G2SrH2FLyP2FqHlKqDtK4L1KI1R+biB1JxHjLSjN6JnGwFvNtQgDwIpMjFxF/NK6JnS5G9MwXxO+SqOyLjHoTkD',
    'Sworgadwari':
        'BBUismRw+wyBtNCxLkHnW3M5J1LMxL5JtSoLhJjY7IoO5kBuRnLuRxB4F7JuHyLoLiEgN4boBoP4L2I7CmX9QwP',
    'Airawati':
        'BBZ21jRyq0yBlL8JpK9BzFhM7LsbxNyL9RNqC/GxDtWiDrQqL3VsG5EoGxW4IoCsJxJsGyElClfgGlC6E+LkLiE8C6RlCwHuJ2InKgV8F2H',
    'Gaumukhi':
        'BBV8umRi51yBlI5K6D1YgJiBkEnU8FxFoG2M8M8I8GlFoMmNyPrCuXwLlIgmBtJ0E3PuR5LxBvPrKoG3QvBtMhNnC7K8F',
    'Jhimaruk':
        'BBQ8umRi51yB5OgBpGqKxOyDlN1F1DpOsI/P7BhNzE9S+J9E8CxR0c8BgSiTjEoU/IhB5D2Y',
    'Mallarani':
        'BBWg/kRsj1yB/VxKhTrOgF7R7F1HoK/UtJ1ImCvHI1U+LO2F7BpEyPgOJkFyFvIqMuQ/CvFwN5JoGRkNyHkLhB2JwJwN',
    'Mandavi':
        'BBQuskR8vxyBnXgKjLhE7JpKnC9gB5H1JqOrbmKO+KoNuC9U6Y+HnLiJ6JuSLyL6J2LlUgN',
    'Naubahini':
        'BBaospRkl1yB9YjNxPsCnMlN7GmF7M7InG1M7FyF/RhT5MvBqFrMmKpD1FpHMxPsH1F6G1S8G6GsJrF2P4W+KxCmNgZ2InBkTgV8QqEqIwIzBwY',
    'Sarumarani':
        'BBY8whRo/zyB3Q7QoG5M9H7K8E7F/EpNwC1OlRxL0J3R2R1EsMhDsB9HiMiJ6IlCrBjK+J1D6H2JmBqsBqCsUrGxErJyJ3InCnGyWrG6E',
  },
  'Rolpa': {
    'Rolpa':
        'CBT8krRkuuyB8E6a5N8HpU9D/LhD1czWuM3MtM5E6QhVnV1Q3F/H+L7E+ExWgSuKwE6HoamPgPqBoGiGrGgQBQxvC4mBlH6C+B6Q/D4L1DpQ1MxJxDtYtJvBlHtQ6PzcmH3NkF8U4MsD4JqMxImQSgL',
    'Gangadev':
        'BBU+htRyzqyBjT+JpPjBnUxIPzKhRyGDtM1LO9OlJuGjJG/PkJlM+IoBqN/IiE8PmL3ByIoOmTuJ8GzCyP8G',
    'Lungri':
        'BBUs+oRinzyBtM5K1IoBlN/Y9KyC1P3WrJsFnHnQ4YpE6J/KqEhNpBvNiQsH2K4LgOyD0W2QzL6DlM2M4LsU7D8S',
    'Madi':
        'BBV0rrRohtyBnGhG/OpBnalPnM7JiB/b6BzO8H1eoToM2LNEuMiRxGQ0KoUyIvG0H/CsSnc9GN4G0LsG8F2TjFmC',
    'Paribartan':
        'BBWsxsRsiuyB3O1QzUgXjJuFM7cmH1Q3GjOkFlC7F1TzLrGO3Goc+GgDrSgJ1J6MmDkT9JsKqRiJYwDqVrU2L1LghBsBkL',
    'Runtigadhi':
        'BBb8+nR4osyBlH4NzQqezGtC/ToKlGlLnLhEtHxL3F8JtRyB5F/D0N1UsLrDlB5NiF9OuFvIpLhLkGhHwFxWsMnZ0gBuGoGoN4J0FvK+VtM2UiWiHqFhG',
    'Sunchhahari':
        'BBhBs+oRinzyBuHrM8D7S3LrUmM1M0L5DzW1Q/NxDrDvHiGhKyN5H0IwD4RhKmN3CgT6EoPzH6J0M7cunBxGoPiG6HsRoH2EmJyZyMvBoGtOmE5L0RpTiBbwMlLgJ/O6CkB1IpIvI7QpE',
    'Sunil Smriti':
        'BBdmvoRmswyB3InJhQrHqBwNpEiN5JgL3YqEzF5HoB5R+QvP8ClX3L1InBnP5GxQgUnKmKgF8N2NyDuY2MyJ2DqQgE3L9B5QgVvG2HsKuQkLE+E3RiKzIvDxN6H',
    'Thabang':
        'BBVonsRqxyyBxZxM1ElJrRnHhG5HyGnP8ctnBnL7M7E5akJtF0U/W4O2QrBuKsT2SjJ6JiI6J6B8O7HGnHqPCqNjO4b',
    'Tribeni':
        'BBWi/pRw2pyBnIuHhEoY5B0OY+XhMpE9EyW9L8E/DkN3MrDrJ1uBpFiGhWhHuM1UgP9kB8X3SmPjF4B/GyNN6GiKkN2CM2P',
  },
  'Rukum East': {
    'Bhoome':
        'BBhBg2vRwquyBtQsE7EoTjJ2D9E6LnHjBG8Q7Vua7C6OhHkE3MimB/XiXBpxBkO3bBpNoHpP8HF5B7OhI5JkJ5JrT1SmKharBjL2L/gBuU9JmJuJnH+asNiJ5C4NqLsCwM8FwJtLwC2M',
    'Putha Uttanganga':
        'BBtB2yyRmwwyBtJ6JpKmB7IxKnOgCxI+PhLtBmBsMqKgQlH2OkMqJkEkU5PmHvI+W1J4F9FhHhOsB1HiPxYrR5K+FvH0OnRtHwPrcxBvHjXtBvH7LT3T4L7RsChNiHjE8C5O8VtaF7QoHkB+E5LkJ1D8EnTuQrEyNuRlCqHyJ6H6R9K8V5H2HmV+J6N',
    'Sisne':
        'BBqBs1yR0wwyBjRpV9J5N1HlV7V6H5R+KxJ5HmCpHhL/LzBxLzN/CvC1MvJuLvM7FpLrC6C3NrNhJoH9a8IgX4PHtBjMiJ3agKrU2LyCC4TxJ4UuQmcyLqJ+MOqD/FwR3CUjW4QW6GgMwSkV0J/D0M8GgO+OrK0PyH6NnG0FvFmX',
  },
  'Rupandehi': {
    'Butwal':
        'BBT4w9Qy2+yBlQiG3LMzI7OT/RlNQzSxLsSxN+GqCpD9f8GC6KiOgQ1D4LwIoOW/G6I2C4OrJwG/B8R',
    'Devdaha':
        'BBa6j6Q+zgzBoE3VzNqB2ElR8TQU0I+LwEqSjGuBmEkSjMBvIoL5M+PiEkNnIoFyGjCiU/ModMkM5K6OB+HhP3C9LxSzFavLvQ7a4DC2I',
    'Lumbini Sanskritik':
        'BCWm65Qgl7yBxHdxKmNtNjM7C2F5O9G/EjJ/M+C5BzH7NI5FxS4OhZiI8IuHvIwQiGiO7DoOsHgJ7CkH4I/G6KqHoFoCyNEzfpDmHjKvaNKmK',
    'Sainamaina':
        'BBVq+9Qy08yBjPoE3LvI/P2D7MtQ/GjPB3RiWhS3QrL8VhF8BhO8UtImU9BiC+IjHkM2DyIR4OoH0LxBuUjIkO5K0I',
    'Siddharthanagar': 'BBK+i5Q+o+yB1OkGkC7tB2IpJ2SoU1G+E+J2M5B8JsHqPrQ/O',
    'Tilottama':
        'BBR6r8Q27+yBrGmSjSkMtBlEpSkG9LvETzIpNoBpC1TmFxTgJxIvE/OhKvByLjKqTwF2Y+MgRiE',
    'Gaidahawa':
        'BBWq+7Qkv7yBjPyG7J3G/R8CjQrDmBtJ5JP0ErMnCxNpHnFgH5KxHxLuUlMoPoG0T8SlU/B9B8JiSqBZyMwHyG9J0ImV3B',
    'Kanchan':
        'BBPw/7Q2i7yBnFzDlV4B+JzIvHxGaxMhSpB+B7JmUgCpBpJwT1FieoF9BiO7ViF4QsL',
    'Kotahimai':
        'BBQ624Qi28yBjTmGlEnJrMuHlG9EsCpO9H1NqO1EoBjXgN9CgFkJoTsKjGwT3D5LlD2G4BsP',
    'Marchawari':
        'BBNk91Qg66yBiL6E8LsI4F+T8MyI0IwDrCqO8DgLtKpB7H3LnIoChL5IjQ7W',
    'Mayadevi':
        'BBYuu6Qo07yB/P+LsIgJ1GyLrSjGiG0G5B+K6F0IiBsX5NjP2G9E1SnU1IqJiDvPxI1F3BrPmD1G4D6L4FhIlBxUuNkMyKlN4RelBuJ',
    'Om Satiya':
        'BBS8j6Qus/yBtJiT0NpBnE4VrLShEvJ6DvP1ElK7J1ThGoBEhZ8WkRrHpP6H1RgJ4M8GrCtFiShCgK',
    'Rohini': 'BBM+35QwygzB/KuG9JpC5FkK1MuC4Dj0C2OjGU+ViGnB8J2T2EmK5DwP',
    'Sammarimai': 'BBL8m3Q2+7yBhNxD3F9T7LrI9K9EoS5QqLkE0GtJ6FyS8NHS4e',
    'Siyari':
        'BBTk/6Qkr9yBxQvFxLkKiKwBwEgPxNuCtM3NxF3U6B9KhGzGsSkG2GxLrI/IqP/L+I8QiPwG0BgKgKmE/EiJ',
    'Suddhodhan':
        'BBRmn8Q+l8yBtFBqD+f9GpCrSyNzM9FoNpIgFhJ/JlEzB/JhPvGnI5QyHrFqPC8J4GwNnI0K0Q',
  },
  'Dailekh': {
    'Aathbis':
        'BBXyu3Rqh5xBhDnM5UxM5I/ZlQ2ClJoMCqJjP9IzCwFvMhYwKjH8GjN4JA0BzI8YjMuP2IoT0L6OuPoI2Z6JmQwSkblRLhI3G',
    'Chamunda Bindrasaini':
        'BBPit2Rki6xBvEyFjoB7LhS5O+DtGnExSpTlK0NhLEzG6N5L6MmYqLmOiM8DuG0UkM0M',
    'Dullu':
        'BBQ2t0Rks5xB1FqP8D2MzL1BhSqQnFqS5qBBvGtLoJxe2G9J1EtJ0LxOiY3LmUvHqTmKoEyS',
    'Narayan':
        'BBU+jzRii+xBzF5D9C3TjHvFiEjYxEjMC1UoQ1EySgK4GmKsPlB6MuQ6LzC6I4I+B8L/JwG7RtIjIsKnRxCrG9F',
    'Bhagawatimai':
        'BBVoi0R+r/xB5KhFpgBgGzTqOzLhSpHhBpH/U4BlH3N3NyH9MiLpE6HvR0MzC4FnNkMtD0BmQxD4MkHwF+C4ToPwQ8TqN',
    'Bhairabi':
        'BBW6g3R647xB5SxPtDnQ1PpC9RwJhWrIlKuD/MqNnMqFrGzEkFvSiSpQ0L2B7D1MsGtOiS6OkoB8L4C9F6U+CiKuG/D2I4Fqd',
    'Dungeshwor':
        'BBQijxR6w9xBlH5GD9K/J7KvBtO2O9VtC5X6NxC2M2FkH8NqUsF4D2ZjMuD3FoNzM0C5HwR',
    'Gurans':
        'BBcg3xRk76xB1M1F5NyCuC6X1O+VwBuOgK8KE+KmH6G5FqN/XtClTlSlKzDkNldmElRsIrHsDhQjCvPuJtFhB9IgL5JCrJ0J5NqQzKgE8T2OmB2EuJ1G+J',
    'Mahabu':
        'BBSu02Ruy8xBrD9GzW/EnMqK5IzI5L0C5MtQrPmBpM/O0K/DgNpNmKtDiWsI+RvJ2PqCuDoQ6SyPpH4H',
    'Naumule':
        'BBXoi0R+r/xBZ7PrczVgChOuNzbsG+FoRyCkIrK8RuIgKvG9B7LoMtK0WgFuH4UPiKtVyY9G2QJ8P+H2JqBiNvF0F/gBgDhPjT',
    'Thantikandh':
        'BBR0i3R8g6xBvC6DhTxCApKjMzMtGzUhM7D1LlP2C1FkP+IBpJmJnMmQ1C6Iga6UyMiDoM9C2P',
  },
  'Dolpa': {
    'Thulibheri':
        'BBmBmm4Ro21yBzT3BlIhG3P+EhFnZqG9NhahJ/b1IQgJjW5D7JwEhVwBjP5DkCnahEvKkFtM1E7P+ChQzGhLkClL1J5JqX/OwFlXoGzFkUmIiK4ayYwL8J5FsLwVoJsKzN2UhE0SmYoS2RF+Hkb8KoB4P8L0F+Q',
    'Tripurasundari':
        'BBdoj5R0swyBpUuJWqL/V6Q/F2sBvR6J9N5BlYnSiEzS0N1UnJrKrLvV7J6FxYvLhK3a4M9N6c1MJhQkIrL2H4F+H1JyMAoJ+JoFmPgJkH4MvEuLiE+BoP8PkJ',
    'Chharka Tangsong':
        'BBtCw06R6p/yBhIoIZwWxHpBhK6L6D2N3NkOiLgP3M2DpFoI7OuCtC9RtJjBwBjN5H1IpI6J7MtGlP7E3S4ClQ9EkCzK7RlI/cvfzTlSnNiErI/EoBlKlRflKgFnL7CzGvSnHlbwB1NhSxQwClTjK/hBiN3djGnP0G1LmClZgTgM+NcmM3F6N+E0UIoC1dsNvkBlCvOyNhDmQuU4ViP8J/BoPuIyF8NgOwH0KiNlJ8FvWQS2OnF2E1BsV0EyV6cwI8FzGwhBoGqGiI2P5YoOqDgK8HzG4LjC+M+EkKsG4fyTmcgCyYlG8Q5OiL',
    'Dolpo Buddha':
        'BBpCw06R6p/yBxJlM6OhLmG7Q/BxYxTlcrG3f9EjKkC9M0G3L/J7HnOpD1P6YpGhIvhBnG7F0G5cvIzExV2BrVoF1ER1OwWPmJ7FrOvOwP3U6E3SoP/NgM8IyO4Q+E0LqYtJuN5B2MsLyI9FjC0S3GsKmE4QgJ8LgXrG+NwLuNiCvEiNuNgYyQ5H0U9dwNnPqWnI4O7OuGqTuP8TwUoQ2IoYjEwMrDpR/HpBhOkJjJZvFkJsGkVlJsS3R5Bta0XhCyV/KkH9N7IpNiCrFyNrNiGtMnFlUoP0CkK7J4HjHsO',
    'Jagadulla':
        'BBwB+3+RipvyB3KyCtEwU5L2KhBwM7J2CnS/K7P+Q7N8DzJ5N5W0IrH/avVoPpX1BjKxEzHthB7PjJ9BnPtLhEtQkCkRrcvH1J2OrXevY1EnI+Ptb4VxWuHuI2DoQxEmaqF+XuJiQ2GqCyKnUya3L6JkNsOwE+I2TyODgMrMwM1BqJtMsTwGyG0Q2ByXvQWhIoLgRqc',
    'Kaike':
        'BBmBuo3R003yBnKhGxF7NnPtI7JgC3VhPlQtUxNiDmCwOrNwkBnC2dzUH5N9ElM4F9Nb/S/LvCpT8XxVkH3bnBpImI7PhC/JmVpY2LyGiVvB8JvEkW6DP/Igc2IiaiJpG+NiFoZ4P9EmIiG0T4B2FgJjP8N5E4S',
    'Mudkechula':
        'BBYgk5RuhqyBxR6V9Pub2EoIdwY1OsXwH2JjRscxK9TnJ9JxMAxPmK2I1hB4EjE0K1dIxY1O7OTrN6I1RqIhMoOmHkVG2PqHoXoB',
    'Shey Phoksundo':
        'BB3CgxhSqq6yB3IxavUnQtP7TtGpT3O8OpWoIvNoPzU+dxQ6HtN/XwEhNtNhC9NvL/WsG/I7LlE3Q4GrKkCzSxI+F1MrLtN6BpYuJ9EzL1VrT1KjP8HrWzF9Q3P7L7KnB9HjbmMjFiFjVwCnagW5QVpLsRzJiN4EqX2BwVnPsHgb6WzI0J6N8N7D8P9QoSgL8J1CiBvM6L1KuEvU4KxC8C2H+XyMgGhH8R2FN0JgHgYsEdqTgP6BsGuqBvPqGqBoHiTuZCnDgV+JwRwC0chI4I7K1EtHkKwG+f3NgImC4HxOmGjD+N9JqCgB2MiD4QoFgQ3FuO/L7DzCoK6LsNxDoNjKlCjH+KLwS',
  },
  'Humla': {
    'Adanchuli':
        'BBRqyjSgvgyBAvN5G7HoDpLnU1LrKvMWvP+NsGoiBldoJlB0N5KoauBQkW7MkfhU6JH8QhHsO',
    'Chankheli':
        'BBlC6/kS8miyBsKtZ0OgM0DrJgRmHkEuOwKyH4RnJyE0HtEiSwLiGoLhF2O0iBN8QyG6HoGkY+MqDmK4PiS1DsOpNuP3W6CkK9CibwG+H7JqY1HsBlGuMyH4JzBsI5WiSgKiIjB0Kxa4hBnFqSnFtBlL6OrL5FvGpLxHyCnL1QxOsJ7CnR/PlD7GoG1K3KuClK9OtB5J4EpF3ItToK1IXrN3M8DrToI7NpC/PtM9T0G5MvBtSvXqB3B1T7DvU4CrI5HvI7G7YqL6G2H5H+U9E8UjV6IQ',
    'Kharpunath':
        'BB8B4mrSu9kyBtP4WrOqNhS2DlK3P9MpDnGjYxG5HO7Q1OziBnLiFvLhG6B/X8NvUjBhR6E9JvUjVxR6GrLtMlI5ZmMtepCrHwM3LwiBuE8F/LqHoK8VmIzJoZgK2UpD+W6EiT0H+L6kBkeiKZ2bqKqH0IgexB4ZtQiJ0C8GkMiUasN2N+Z0NwWuG7DmJzZyK3QnLpLqEtL1LhJ+Ie0IjR8H/F2OlCoP1P7CnEuO3KjF9L9PhEkJ7VzM',
    'Namkha':
        'BB3CoixSmm/xBnKlJlOsOpXvJxLyJ7YuE/F7KtLoG7diE1PkGlJoLzPwDrLzLRjOvQnHvWnX3BvJgOlM6IlQgHqCqOhJjEzTzGsKlOuEpFlF5KqGlDxWjQ5L5KrClInIrFtKyEnP/FpMgDxIjItG2C7R7G5OVjV9KMhLnPqItW0M2DiTlG+O6KiR3JoDjPwJjS3JhMkCxPuJjYoMhdqP2J2a8BoYnUmF+c/DqRwPyL8R6bub9B+GwKiOgE4FnIsHqNyL5QgI6FsVlFAmO4H2F8HpRiQoEzB+S9I6Q/N+NrGucsBgO4TpCkPgI/KoauIwJwNjBpMygBvL0jB5GwB3Iwa8B2VzH0KsBoa',
    'Sarkegad':
        'BBemwnSqkiyBjU+IvKxHjEtO/QlHzDsJzO/LrKuZpMhR5QvLrQpbiYtLiHrOI7QiU5J8MjfkD9PkK7GyFmEkUIwEiHvM4LqCsHlMuemI6ZsLuMyR5GwUkV5E+JkBiR',
    'Simkot':
        'BB8By4wSsujyBvWtG9ZzNrN1NhUZ7GjMhJzC3ZuQ/dyBpHzI1bpKhKa5kBjezH9L5EhTqD9W/J1U0JnZ7VlIpHnKhB7nBoazT8G8J6KsCkQ6LmDyW6KpGqFmFmOtE0GrKkE0TpOiJ/GpC5ImQ/NmM4BwJwWoXwQoHSkOsL0L0PvDmJnL2PjG8dhEuLnGgG8K8YtEyLxJqXwJmOrOuI+EnJgqBkHsGlL6EtMgTyFqP8HJrFsbsN2GsCkM',
    'Tanjakot':
        'BBR8/lSyk9xB7JiH7DrGnatBzN6KnJmBniBmd9NrGqE5XvNlKIhWsTnWgbvDobiL4EwGwXgDyOgG',
  },
  'Jajarkot': {
    'Bheri':
        'BBay6wR4jnyB/M1H2L/OnPxMvH5LvEhJpZ3CpKtNkD5QmFuB9DnnBmHnI2DqLwThKiXiE8RuRiHmckLsDmF8M+LmC6J4MvNgE1CuI3NGjJ2bpOyE',
    'Chhedagad':
        'BBgBy9zRu0iyB1F4DnUhB3K6LjGnJvPwSiIoI+EmV5OoB5GmLvNxGhHlc7RtRhXhEvTiK1DpL+DtP8axZ0OmDqFhvBiKnUmMpM+IgC0LiSzC+SqFlEwFmM8BwMnHqW0EuGwdsE4P9D',
    'Nalagad':
        'BBqBy6wR4jnyBoDlIqOxEkJ1b4NFmL1Mkc6BiHsK8RiK3JukBhNmBoC0ZoMLgNwQ+CmWkL4E+UpFoDpF0gB8GgB+H5I2RUsN2O8OHyYzK2dlG7CvDhP/TzStM0BvFlHvQ+B5JpG/GnSsE5D3OxTtKha7HvItQhHxFzLjBhgBpMnG/Q0D',
    'Barekot':
        'BBhB6u2RorpyBzgB7GnDqF9UqFjL3E9ClW/MvQnMMnCzZiNlB4JtkBoK1L0OzH6I7P6WtL0Vza6MwJmD4I4JWwK+L/BwI4LsOgNsV8HgUuIqFnH0EuC8JhG0NiE6NjNypBnN7EjVFnOlH',
    'Junichande':
        'BBZ851RgjjyB9IjFjW2IndjSrFzU3P+DvdrEzEtGoHpW7BvMvFlMpFmE0C9S0TpOqgB/F2Q+F4N6JmImMghB/C+EkYwL8QuH0JoJuErLsT5T8G',
    'Kuse':
        'BBXoj0R2kmyB7RhKhHrK1U9BnMrM9LlCNlSoT9D9ElVhInIwPvSkGoJ4K5LoUiBiG1D8ciSkW1IuLiJ2NscpO4S5WuL5I8PzO0H',
    'Shivalaya':
        'BBOktvRqriyBiCnN3C3mBwBtsBkNrL2RlFkL9I2I5PuKqK+DoblMqMhKoUpFivBzOlD',
  },
  'Jumla': {
    'Chandannath':
        'BBNmi9Rk4kyBrOuVlPkMjUhI5L3KCrhBqF2BuMvUwP5IkWkNmEkM6PpCpEoO',
    'Guthichaur':
        'BBjBgq7Rk/ryBnbwKxKoU1GpCtJhQpF9XyEla1DnQzL1HxBrK1Z1DkNxpBhE5NiGzNtC7J+Q5JkHkCmFpS4MM6GxLyN5BmR9VwLiKmHToQiM1I4T/LoS2J6WxGyNlU4L1GyToG2TpD8OoHyMaqb',
    'Hima':
        'BBQk77R4qiyB/CpWrI/PpZpgBxL/JkQ9V6K/P2NnB8EuU8d4QsLkOvB6PlIoHN+KnPaIqV',
    'Kanaka Sundari':
        'BBYmx+R29kyB5QTtb2DlB3H6M5YqOpQjEnU3NhM4GlWmWxgB3GxS2YXwG8FyB2Q2Q8IhBuSjGyDqN6QZqbnO2KgHkStOiJrF5DrNiO',
    'Patarasi':
        'BBsBgq7Rk/ryBvD9NZpbnHxMqD7OnG1T2GxTmU3LyGxN1J5WgMnSsFjXmPjM+PxUmB4Hub1D6QU5FqFCsUmNqF6Jgaf8SumBkK0C4L3I2KnC6LkHoNtYwPjHK9EmNiN4MoSkb3N4FxIjDpXgIG+R5FuKrTvGpJuMvM2B/LsMxOE9I1TrOvE',
    'Sinja':
        'BBTkw9R6gkyB5PqClEjMtXlOrGpIlD3VsNrMHpVoPZO9KmInHoBjPqcjEoLmNgB6IlWygB3GmW4NiMkEoU',
    'Tatopani':
        'BBkBgl7RynlyBlR+VxN6B5GyL3MLlFqS5QiDtIpF7H/T/MrV3LrOgCvIvK9L3JVlD3I5MvJjH8DrQpckH7R6T7G2K9Q6NwD6TqBgY7BgRqLkO4S+MvBsIpU+VnD+RsF6J4LdkO2HsJvP6ItMwUpF1B',
    'Tila':
        'BBQs57RipiyB7V5H9VoDrIqU9MwBjO3S/QpL7QhBiIjVwVlTwJ5OAnO0G9EsZ2LugB8nBkLia',
  },
  'Kalikot': {
    'Khandachakra':
        'BBUwi6Rwz8xB3L5DjW8Q3OrPhExP4BjYkF/K0H7pBxF3IkYmDyFmO4LqG2L7BwDyH9HyStKlGhBuJ2KqL2D8TvOkF',
    'Raskot':
        'BBO6z8Rml7xBjauBlLtDhHuI3QlVxCvI6IrJ6KtBkIjKyUwUsEjL+KqB8J0O1HwD',
    'Tilagupha':
        'BBawy4R0ihyB1XtErHyD7EtJ2KhO+CxOmHLtB1QlF9E8GzZiJ9EgD3VlGxUsIzL4OsPkW7Q4L6DsQ+kBiQ6ZW2H9QuarI6FrUpJzG+EAoOvJ6O',
    'Kalika': 'BBJqw4Rux7xBnkBZ7F5cgE1InI3K2JrP+C1PmayCyT4Q',
    'Mahawai':
        'BBfis3R0w7xBokBavCmQiEyPrI0LmGyU/C4VhJ+E7G0ZmF+EuB2QlHM9CyO1KiO8EuJsHxD2XuE9LianZErWrKtHzJvL7Q9EjYwFzFpBhN9H1JK7P+G1QuVxYxE3TiG/V',
    'Naraharinath':
        'BBR+x8Ruo4xB3Y8OnGgKpNuHzmByC9OyG5T7N6G/UuJhGT/P+evKkP2CsIkIuL/CmJzQ6E6J8ViP',
    'Pachal Jharana':
        'BBUu16Rg69xBzR9hB/H1UwOjF1D7T1KpLiBtJuKmG+HxSiYsiBiHtImLuDibL8GoSkC6WrByI1XxDlJ4QjVlBlBuL',
    'Palata':
        'BBWgk7Ro4+xBvO7d2PhLmBtLkVmBmJ3Q2XyDwGrEoPiCiQ+LhC6MkZiGoQgHsDyjB1KiLSgXnE6F5gB/DhegErJ1O7d3Q7EtU',
    'Sanni Tribeni':
        'BBX098Rqy6xB7JzO9KpBrEkLxUvUjIkK5KuBhJ0I/HvL1L8B3LpGrErL+OxG0mBxCqNtHoG/JgTxN0M6BoIiM0LuG6BmJmG2blK0Q',
  },
  'Mugu': {
    'Chhayanath Rara':
        'BBnBorjSwkmyBxpBhI5Q+P4H6OvOzE/LoDrBgL5NqT1UzJ5Y9EgB7S5J/ZlNpFBrUkG5LsNhOsF6DuOhJ/GjSoO1KhBjPoLrhB6LtGqFuLkU6B8DiG7OuM6HmUrDiT0QhGwJgEuDniB4gB0HuDqLzJwM2F8Y6HwI3CsI8DwU',
    'Khatyad':
        'BBd8zgS+1hyB9D5F5LuG9IqX3N9SkGxDiBtS1Q7IlBhbR/W2KhLzC5kBobzMsD9PuGmJmb0NuX5F2F9J6J6KpO0O7FuMzPgMqD6P/GoNiEqKhC+WwEwIxGkQhL4K',
    'Mugu Karmarong':
        'BB3C0pgSi4nyBqFC6NpTsB/KgMnDwO0E3H5O6Q9P0tB0JwTlDwBuSzG6MuM+TqCgQnI8N7DsTsN4M2IYuTnKqF4I6J3E+OuBtCmK2K4K8GnGgQmD8CoRyOrJoL2QyHxCgRmS4PkU/J4TlOoC/GqL/W8O/FmSvH4BtP7M1CiM8FiXyHmNrKsIZ2IrOgIxMlP/B5LhL3ErHgHyFuQpF2UpT0DxH2VqB2M7J7B3J0HtZBnHhTpGpBtqBwP5BrGpT/OrEe/G/XOzJ7R1F/FiH9XxMhEpP7H9B/QpciInLwQV1BxXxGzQ6FtKF9RqX/HyIkD4N3FnSjbhN3M+ElNkHJuYvPjHnN0IxP',
    'Soru':
        'BBlB45iSoyjyB6KvMtDpL3gBzHtDoiBvJ/DzQiGsDhT5HlU8OtM7DhGjU5ByJrDiL3KyGjQvEvIiC9WhEpKgHnNpD5P0P/L8FtMgSnP/EqnBsKwMoU2LnDqL6G8HwB4Q8OiY6QwL4NsS7BwP5IP7UkV9U+E1H6H',
  },
  'Rukum West': {
    'Aathabisakot':
        'BBtB+sxR4zsyBxBxV+D5KFxZsUxQ7OlEtH1VnJtDoC3HlEpUlFzDgDnO3IvJ2DxK0OzCgRzDqMoGkBigByF0LuQiH8HwIuKia4OyTrE6DgHoS6JqGwQ9BwFmHuMzBgU0SkGuTtIuZzJgQKiQ5c2M5E8HrOzE1NwCxH5NsKzP/N9OzM7GzJgEvSjV5G/L',
    'Chaurjahari':
        'BBPs3uRmvoyBnRdsG7HmEjhBjC7IuK5VvB3JyJvMM7KycmGsL4N+B6NhSqlBxJ2NvQkB',
    'Musikot':
        'CBTs9vRsrryB/Q3J/JsUhJ4auBkM3PItD7QzOxP5CnV4PpQVlZ4OvC2FtHKpasMsBkK6L7CsS6RyR2BgWBKjiHsyDnJ6ElDvPR/KyIlQpIpPqIjCoV2Q5QiVuM6E',
    'Banphikot':
        'BBU+sxR4zsyBTkWvR4CpDgG9MNxLpJtQlcyJ3U+IjX1B/VhPrL6Q5SyK+J+R5KyP0DuH2V8OmErUyQGyZ9D6K',
    'Sanibheri':
        'BBV+jxR+rpyBpGF9R6KxK9JhOgMzC3RjK5L3P7FuBpQmHxJwQjByJ1NwSnqBwN6K1LgPmN8N1DyK4IwJ/CoOmF0DmEqU',
    'Tribeni': 'BBOk2tRunryB5JxC1KvToCvS8G9R/DzKqX9FoHjOiSewEuInCsc1FuH3OwCWmZ',
  },
  'Salyan': {
    'Bagachour':
        'BBV+krRwtoyBkB1X9FyFxBvQpG/FyJ5O2EyJmStYoQnBkNgM2N2Y/F4QoL4RkFoR/ImJyCkP7Q/F7G0ClTtJxInOlL4B',
    'Banagad Kupinde':
        'BBlBq/uR42jyBzd0BnMgH1E2MpLHzSjStQK3KxIpJkN5I8H1JtC3D/SgF1H3PpQvQ1ClEjS1FH5B9O2HrL2N7G0M+I4F7J0MxHsNgCM8MwJmDkEwMiT+I8alEuRnPqQ+K8KzEuBkOmOE2D6SlGtB5JyQ',
    'Sharada':
        'BBa6hrRi2myBrGuIrM/DvSxWzPzBsK1I3HrS3JRpFpWkMjXS/KuB9a2JlHwEmKwQ2C4PqQ/E2H4DgT2JuC6I7H+H+O3EoUxGkGCsM7GyBuDuX',
    'Chhatreshwori':
        'BBb+krRwtoyBpNgJ9InB1JwMjN1C3NrJ1BjLlNhCsSlMJ1J3M3T+HrP/L3F1IoInFxL4C/agJ4B+I5JqM8D4HsSrK2I0P0BwSyWsMgEkDsMyBwQ+FxF',
    'Darma': 'BBKkutRs+oyBjFnRnL3RgG3Q1N1YgVbwOoE8TsMd2kBtOgW',
    'Dhorchaur':
        'BBSultR6rkyBpU8XrD2J3DqXpRwClSuYrFpMuGhGtDtX8GxBBrMyGjGmHzQxFzIL7Q8ElG4KyIuQJ',
    'Kalimati':
        'BBjB++pRsmhyB5N0O6B+OsFmI1JmHtB+aRgL9LmX3EzErRsEhQ3NsDvR1N/TwCrKnZlS/ezJmVvVsPjd6KjDsKlY5C9NmG2CqOlN2G1XpF7HkMpDiQ5bsPkFqd+QJ+RvGgVpJwPlG8W5JmP6BkM',
    'Kapurkot':
        'BBUu2nRyjnyBwKkCoMmN2DwLuL7E+DuTmIrC6BiNvI6ElPkF7X4S5DwOtKjFnGnNtgBzG0MvCK7PiVtSHrP+MnH',
    'Kumakh Malika':
        'BBSuwuR8/myBrlB5O5L0DhWnKa/TkH3S6TzX6LA2E1MoM/GkTzE6MyJjEqNjD6QiHgKL8KxJwMjEoR',
    'Tribeni':
        'BBY4ipR2joyBtGlKtL8E1DvLnMlNvKjCtE5fgGlKjEvLoF5S7IrPoKtJiQ4NsRrEuIyJvDiUxPgC3CgboFyL2InIgM4F9HsP4M4TK2J',
  },
  'Surkhet': {
    'Bheriganga':
        'BBY++sRwi7xB9D2KoEoMjOsb7YyWnHwe1P5H5QvFL5U3MxH0EvVkK9S8OpRtBzJoSrU0FrL+Z3fHtL6NnBuaK0C4FrVgMpO4SoG6W',
    'Birendranagar':
        'BBY8nvR6l9xBtHrMxP3G4LzLiD3eziBnGzWoHvH5GLnWnG5WqO3SsV/LsLpHiSkMC0NuNpE2RmL4P0C8DwYtJuFkCwPrDiQrIsHlEmR',
    'Gurbhakot':
        'BBX6ntRw/+xBnJ+FvT4dzYgPOiKrN/BzMyH3F8JxFlIrN6CrO9V5BjM6JlPmG7WqJvPUvNyGzE6QwF2P6H4EpPoegN8OuB6I0N',
    'Lekabeshi':
        'BBT+xuRyz8xBvQ6I1CsHkIuJQmLpQ+JvNoR1GxK7OtBne/MwClP8YxWkOrbnEnM+D1KwH6G0WnH0iBoGhD4e',
    'Panchapuri':
        'BBgBqnyRwj4xB2HzP5J9MrE/IuB9PjKpLhCnSjIxBYuM3I+N7KzI1H4F9IvT2ClWhJiBxJ1NqG3cuOhDmGrI+NmCwHvCicunBwdW6O4J+U6DgB2KiOybhMkftZLnH4PlNsGvN0P',
    'Barahatal':
        'BBrBqnyRwj4xBzP+L/H9HQiPpQ0KzJ6NBsJ/K6J5CxP3PzC1RlLtNqEBzNpJnKxLkFlLtFtaJ9B/MgH9C4KpXiH7EwF5T0PjGsMhP4K9XqIldkGhD4MsG3CsGyJ2NiJhB1CmW+IwT2H3F8K0I4I9NXtMkIyBiCoSkKqLtB+PsEgJ6J+M',
    'Chaukune':
        'BBmBmo0Ro90xB9U5D5O3JvdVhctnBmNlM2MZuJnMqIkK+LpFsNtRsHxDvSjD3JmG+KrTvCrNiIkD8RpIlN5LjEjOqLxI2HxJflKuJ1KoT5LiMpZiK+K1B2MkQoS3EmK7EmjB1Zie9H+U3BuV4FyE/H8LgM8MsCqM',
    'Chingad':
        'BBU+tvRqr/xBvUwTzG/UtS7FzIoE9P1I2FlT8Z9TPlLjItJ2CrH0RnJsNqG+JwR2HtBmTmSqb8F1I6PjL+I1RmF',
    'Simta':
        'BBVwzrR65gyBgO1TyJ9CwT3diQrGkJkJ0InEuS8F0GgVwUvTvBgsBsC6uB9RrDtBjO7K0EpQ9KtRoP7amEhT9IjEvMvJlD',
  },
  'Achham': {
    'Kamal Bazar':
        'BBTk64R8m1xB5NdrWqRyDmGlPlCjN+QrKjH0JvZ9EhU3GjEgEnMiQrZ2EjQqKP6CySyHkL2YxBlD4WoHiJ',
    'Mangalsen':
        'BBX415Ry90xB5avEnHhJmD3W1YyBxHjL5CxS7F0D1IxSkBxJ/GhS1DjX0WvI8HlHuHhFuL7CYmKsKqSsLiMmDwPiMmQ1B6TkB4a',
    'Panchdebal Binayak':
        'BBTm92Rms2xBkN9QmPmCxDlGsWpRkReegW0LwFyCqJ7HoG4QmP2DuQnNsHUgQtJiGlHwTlW5iBnI1Z5OtP',
    'Sanphebagar':
        'BBb0p8RyozxBxPlO1L5ItFmTnI/FhJnF/YyCjN8E8DzYiR5EZhNmLnCsJ+HA3UiM0BoC7P8IrJsNL2MiJnGsSsR2E0HlC+JejEmbuKuE/GsPrNgC',
    'Bannigadhi Jayagadh': 'BBJwx6Ri00xBzNoOjOgBvD1oBX1ZkN7EgZxCxGqT8DqR',
    'Chaurpati':
        'BBa+q8R83wxBlMvIrNM7IsJnC8PhMzBA4UrJ9HlLoCaiNhR6EzOtMlDvPrLhMrKpS5BnNwV7W2I/FqVpG4HzL2B+WsP6ckHoDkI3K+IsBsY+N',
    'Dhakari':
        'BBSwp3R09yxB1EkQ/TimBvJElYvUlR1E9NtVgI7L3FxE4BtV+H9U2Zhe+BxKoFsIkMyR4SL2DkXgHiS',
    'Mellekh':
        'BBQi77R+j2xBhZ3PtS/lBsFhQ7DpRgEjJ0L9EoIgGuFlT2L6IuQkLwE+TmJ6IzZmc+J+U1J0F',
    'Ramaroshan':
        'BBVk55Ryx3xB1DtQ3QlP8HnGxCpJzLvFd/VnHhJkMpGwTkGB2FkOfyNlOyQigBiZ4PsFwLtE2PnOkXtLgDrIjIjP1C',
    'Turmakhand':
        'BBe6y2Ril2xB7G5C7YkMzB0I3JA7GkNlQ2KnI+PjVyO3kB4PvKgOvNoB1FhRjB3TgI+HkMnMgM6EwNzPmNrGoH3PuZMiMjf1MtXpC7QgT7UyDxMqQ2FmYwUmQyD+EiU',
  },
  'Baitadi': {
    'Dasharathchand':
        'BBZsuiSokjxBxKxLrPsI0CuGtGoTtMkD7R+QtF3GlR8FgGpOvLlH/EjQuP9C9E7OwLtJVzR2GvBiHlQyFiG8EjK8HSsF0WuGOiP8R+NkN',
    'Melauli':
        'BBW08/Rw4jxBtMgL9NnByBhG9MtH5LgC1M/S+DnGpTpIxElhBsaqHkDwIqMnM6W6F1FhMkF1JkL6IlD6K2JiRwEiZtP+CgFkQ',
    'Patan':
        'BBjBk//R6vnxBzFqGvR1CvIyGfwKzL0M7ChE2G3S5DlI5KiG9LxR4I5VCrVwJlD+DpQlMtBpE7LuEvQnIlOwG3N8NgNuEtG+MuHxBiG+NoBgO7KwDgH/FqOmR7FoE8E7KyGwC8kBpBiPrJyHtC4Q',
    'Puchaundi':
        'BBZ4qjS8spxBhJT5DiSpFnGnMqErmBpKcrO/MPdvRsNvViB3OnJpX4HjDpBhUqSIiFiPoU8F4CyTzGgE+SgDoIyLkMlF1E0L8G6B1I0Q',
    'Dilasaini':
        'BBY4qjS8spxBqC3Z2IzQ7G5B2EzLjMmFnIxL9S/C+C5L2BjV0IjJGnZqG7byVsnB8EmC0BopBpF8H4DqOwKiH5C0NoF0d5DkQnImIpOtJ',
    'Dogada Kedar':
        'BBR0uiSoxmxB3S/ChFhPpSH0Crc7GpLoUjR/DhMyGxSzCtGsPrIgQwQhD4KsCyRuKuKjDwNdmkB',
    'Pancheshwor':
        'BBYq9/R+0ixB7K1ZmD5KjL5I/FkLpP5F5G5JvKmG5GlQ2GhJzPhPyN1EyMnVgW4C+DqjB4N9JgI8FjC0K2JqBoGsQwIsEhHmQ1GwBW0R',
    'Shivanath':
        'BBT6n9Ro2hxBxHqCrL5XjG/H8IxP6NhKwPnFZkH0PiP1GiJ6GmQwKlG6G6J4HJsPuMnBqE5W5FpMoMjDvI',
    'Sigas':
        'BBb24gS2jpxBzEoU1JwDkF4SvJ+DjH+N1MmH9DqM/M6FJqOzS5VzDrN7FkFjLrEyB7KnKlNe9RiM1O4ImD8Ftc8R5OgBvKwIxGwR2C2IsBpCyKgVuR',
    'Surnaya':
        'BBUwkhS++lxBqBiU3HkDoJqXhB4OlLgVlGqC/UtRqCxKxG3XuC3QsJxHqBhPvC7kB8O7EiP3QuMjD8DsLnUkR8GqL',
  },
  'Bajhang': {
    'Bungal':
        'BBnBgmmS6hwxB1KDpPrIhSwCnKtF5K2CvIlGmFjL3MlOpLApVrNKpJpb1PxFpUxGrNnHlS+FlI8FnKlP3DwBxR+HZYrhB2fgHoMpEqFoG6DhSgJWsC4JkO6KR4b8LmPmSgvBvIiWkMqIU4ayJ6P+XgHqUqBoE4I',
    'Jayaprithvi':
        'BBa03iS8kyxB5F5JvG+N9KhDjJ0KzMnG5D/IlEoNnP0NvOsTjMgU9C3MqD7S1H7Q+DhSgGvW4InFwJhSgM9JsKb8Q6BWkMqM0GfgGySmEmG4L',
    'Bitthadchir':
        'BBUgihS+orxB9IkMnOH9IkLhUiB7M2GKpOgN5F+DpM2MlHkH9NwJ9DjF3S2JvDkErT0ObbsOyFwDMmhB9Ha',
    'Chhabis Pathibhara':
        'BBO+uhS4nwxBpVwBpR4JpJxxBuNWoT/U+dzU2KkBmMoJqD0OtI2O9NWPmTvLuG',
    'Durgathali':
        'BBN0giSk5txB9gBgU1K0P3X8GtF7PwKlTnFnHiMvG8H6GyDrHiPzHkStFuDgO',
    'Kanda':
        'BBiCipjSil3xB2GrOrC/NoG1JrElQ8C5U2RjWoOmC0GhHnEvKuDhN7HnLkJ5HoC/K0RpL2UxJ0DnQ2LlRnK1LuEjN6L5E7ElKqIlR0ZO2N/GqMzQiINgOiM6NjEoE6GoR0H4RiT4GmMjGwLjP8KjGwYGiNyH4G3JmOsCoR6HkFgF9JyI0VnMidtJkYjCyP4JiMvJkSnDkPhR4J9O5KhTmGzM1D1G2I8C6VjKqWtQ0Opa9DhFlGtTyH1O/MgErQrHvD1ToKxGnG1Me',
    'Kedarsyun':
        'BBWi0hS4jtxBtQ8GhP0HxDsH7H5GhMwGoFoHnI+I3FxD/H5nB8CxIzL1LoK7IiUhB+IjLoOI0G3L+RyD7FoK9FmIoHmSsJ0I',
    'Khaptad Chhanna':
        'BBS61/R62zxBrJwKnQvc7MtG4BlZ0H5IpInSmKlQ0DjQoDwJ6OjN9BrOkH8F0T6d1NgP/FwW9DiS2H8Q',
    'Masta': 'BBOkhhSgm1xB7X9Q/IrPvHjCkM/TwOrToPzNmEnN8U4W+HkCyCkMrGiDrC6N5Kqd',
    'Surma':
        'BBc03iS8kyxBgC/RlG3LxSlEgB/F9SlVwGnNwLtGQlT+NV+LjRmOwKqLA4MmOlFkLwImG6K1CoKuFiSvCqPsI2KEqJ6MlhBgU1ITnRyQ5K8O5PqJtVN',
    'Talkot':
        'BBpBipjSil3xBxJ7YvM7FjT3BtFnIlRhCjInUwRvR6KpdsC5NsGhDxCjMrMzJkJzK+KiDwG9NwB8J6QsFuVO6PpJ6K7OoRxQ2IUmhB/TnCsP3HoGzDoQ1UyJzRqLnCgLjJ6H8HoLtDiNoEwKzGiHnOlC1RkW7C6UsEmQnG2JsCgO',
    'Thalara':
        'BBQwngSsxwxBrFxCtVzdtMnItB1QvL5HCjKjJvN3Ezdmb7Q8JkB4B2SgI6nB4FyDX8TiJgO',
  },
  'Bajura': {
    'Badimalika':
        'BBWyz+R4u5xBxJrJ1cpIzG9XVhTkC/ckd5XoK9MqI6FxDoLiM9FwLuE0D0Tua6C0GqGrD8QwM2nBzK1C7E8P/KwInUVpIyI',
    'Budhiganga':
        'BBQ6y+Rww1xBnN2G3NzXlItFlNrTtTpNrFhQuQjKiNiLuP2B9H8KoCmOwS0FxCoKsJqCoIoO',
    'Budhinanda':
        'BBY21/Ro/7xB0E5ErJtI/D/btbhViClSgPgEqIxIoUWgLvI8E7PmMCyLkR8IvB2T7RoSuGsUDvW+axHCnQ0kBrKkQnVkOxJHnE+I',
    'Tribeni':
        'BBUov9Rm+4xBlOxGjPlPJ9J7VhP5E7J2J1PxGrQ4EvM2JzF9J9UsYpXJ3I+P4MoRuUqOiZ3R8UnMyHjCgd+B8a',
    'Gaumul':
        'BBawqjSo24xB9UQnStG1T8RvKnG1P9OpIvfsD7QzGpGta5ChHpiBgCjV9EvOsQ3WyFyQ8E1BgJsPgQsIwL4LwEiRmRiCuFoIkT4BwM8FkWo3BsFgL',
    'Himali':
        'BByB8ogSy98xBtK9X4PtIoE9IyJIoVjOsKjQoQzkByHBwW9aiRlIqH9LyGoG2TnKsHwD/DsQ2OgNuTxHiFmGqa+DuQzOkKpWyGmH+KLWkV8G6O1C8RkIuG/CyIgGqMxEoPsFuKpOiOzK+DUsrBtFwIhhBjD9FrIjUHjJrZxO/FvX/C3EvGnbhL/awDrToWHiW1F+JtX6FlbzN',
    'Jagannath':
        'BBU21/Ro/7xB5HhFtQmCra+InKT9V6OjFlEjC5WxI3U8C9NyUnCmKzQlG1b9BnJudsHwIgFfyWubiVgEgcsJuI',
    'Khaptad Chhededaha':
        'BBX6r/R8/1xBvLtE/MqKqFhLlGlVnInOrJpCyCnKvSzFnClO+H7K7WtJ4HpF2JreyI1G6MoU6HwCgBuP8MuGsPuhB1IoOwHyH/BkV',
    'Swami Kartik': 'BBM8i9Rwz8xB+V5OoKUsa9IuQlCyQuLuK+XrD+Pnb0MjqB5LiC5MhQ9L',
  },
  'Dadeldhura': {
    'Amargadhi':
        'BBS2/9Ry3mxB1SyCzU/F3N6e7FzKhI+CzH9L9bjZwB/S6E7MpF1KkG/fuPsL1CoK2NMyKqa+HvFqMwT',
    'Parashuram':
        'BBpB2g7R8xjxB1S1K7QwInJnNzP5FxhB8C7QnFuCqJvJicxZuByH9L2L5F7GzY8DlDsN7pB1BvOuE5O7HjSmEjNrE3O2NrKqM1PqfdzJ6P3B+PyMiN2CuK+NhJwNHwKxK4KiFrJ8HhHuQoNiG5HqJ8FoUKsOiH8L6PG6BkHjF+e',
    'Aalital':
        'BBdog7R07jxBjGggBqF2K5E8MvBgTrFyGxVyGpLlRxJb5B3O/PDnIjZlK+CzKmT9NvK7M9G7JY7MnVkCxSmGmKyZtBwJhctCpJ8QoFyhB7C0P6FoJoN8QvI2S2K',
    'Ajayameru':
        'BBV2g+Ry1mxBrK3E5c7WvKnR4EzGlE7eyMzErEtNyGnUgJ/Qgb0R9DoGmGuKvG4NoImOtEwQqE8LmMuB9DqQvJmDBsV',
    'Bhageshwor':
        'BBZ+r9R4tixBzE7B/IgRxGoUsEuNxM0EmE8evO8JxKpa1NL2CnKtPrL8FtTkF9e5BjH5PFhH7LJrO7FnUyR1NkFoFocoDyVwSsL6XyHpC',
    'Ganyapdhura':
        'BBQyt8RompxB/JrM5OmPlU7U9CtKrYtBLzOxFzGhE1Z+ChGyjB7HqT8T0H+LiRyInBwX6HqR',
    'Nawadurga':
        'BBVyt8RompxB4GzJ5HpRyD1OnExKyM9d0UgGuRVpCmN+LyR6KhG6DmI1G4SrDoG7Fuc3IlD/LyOrC5OlL3C/RwL/IvC',
  },
  'Darchula': {
    'Mahakali':
        'BBWq/mS2inxBzLnFlQ5DvN9hBjNhF3GrJ2F9HkE/OrCxMsHvLpCzJ8G9O3KjNX5MyT0G6EkkBnEqRqRqJuCgJ4MoL6KmMxG+M',
    'Shailyashikhar':
        'BBVmjlS6tlxBhI2CtLyY0H4Ne6cpLxDzK0K5HlF3DpOqF7HzBnpB9LvNvFxPuHf8KnWqJtEoEoE4F7ImHuP2J8IqIqQ',
    'Apihimal':
        'BBnB+xpSsquxB5NkE/NhMhIOpM0Q1NgHzZN1H0SpUpB9X/GxJ5PV/auL3IExUoLhjBmM5bnL0EjHlPiKnF9F9PoIpMnEhEoIzQwSnFyLqNwU3RmCkQ0J3F4UV6B2SxPsU8XkPsC6S6KsHgSAjPggBxCmQkKwHuE+T',
    'Byas':
        'BB1B+xpSsquxB0E3RtE9TjKvHyClQkP/f/RA5KrHrC5S7XjPyPrU5B1S3UWzJ4FmCzMlI1JkEtU4PjRkPnImE/R9S3R8EhHub+P2H8V5FwLUqPkbgdL8L2RoMmN4B2DqK8VgS2HsYiJa6JiU4W7J8PmN+ZubuB0esFsHxIkZ/HA1F8J7I7G3XgT3G+L3dnBjCgN5GmE/TjL1G9N3RhTnRzH',
    'Duhun': 'BBJkwnSq4nxB1J1VjHCyDloBoKrOkTiP+S4RlEgSjPoI',
    'Lekam':
        'BBRiljS4zkxB9RnOrCxRiD3KtE7MnI3M4P2H2M9CsI1PiLtEmCoQhE0J6QoIuC4P3DoLpJuE7KoW',
    'Malikarjun':
        'BBRijlS+4kxBnN5QlHtP3F8IejQ7DjP5QnIiEzJlCnQspBvLmH4MmDkT4KkN7G+OqC0JrHwLsCyM',
    'Marma':
        'BBao8kSy5txBhMhIwIhWlS/uB7LlPhCnSiLhT6DjQnFzd+E7U6FnFqKuMkDqLwLgFyBkI6V2HnI0QoEiEnIqM+F+PhKoFkHmPoLzElM6bnLijBDyU',
    'Naugad':
        'BBU6vnS+yoxBvU4RxLpNjXmFlRzHxBjIvL/E9IjUqJ1EtDlYzH3NuLxYsH/CwTmKwN+hBmQ6DyGmHmM/BwJ6R9DqY',
  },
  'Doti': {
    'Dipayal Silgadhi':
        'BBY668R4iuxBrLzBvOgOvKvFtFuY1N9ExP3LnQIwLpT+HpM2L5OpIrH4M/LvFzHqRpKiHvQ0FhLqNoGxOuOkK8UEwU/F8H+OqP+MjF',
    'Shikhar':
        'BBiBkw9RutpxBhI0DiBmKnKmQxJvFjIuFsJiOlGuM5QxDzFiLhHwQvMoO/BkJ5J6BxJpJ3ZvFTzDnbvP4BzF8QhHL7S2D5NyLlS2IpWB7WkYsB+CuKmU8UgElIkR5D8D2MpE6IgJwCgSvL',
    'Aadarsha':
        'BBX0p8R++sxBlBhTjK7UuXpXxIpUkItFyJwFoKlQhBlKiJkDDgZoKmNxB8KkLsEmLgB9EyMjNiO5JoIjMyRtH9J3F2FciPjHK',
    'Badi Kedar':
        'BBhBu74Ry1rxBjM6EjGsP9M+FwC6MpE2avFgM/L5HhOiFvK5JxXgE7R7GhC9PsElSpHrIiClKkHrIqNS4EzTxZtNmGpO4OEkL7OoD1NkG6B2G3QgY2CpEuW+GWrFiMsNqP8SvC8SqX',
    'Bogatan':
        'BBe+m1R4ztxB8R8GyX/DwK6JiOhFgM6HwF/LqE1avC5M+M9FkGrP8InBF2KiI+TrBqPxI2XsJ2KkLwDsFiWvO8GvV8WrK+FtHiFhY+PlZEjMxRhG7MwIpejQnS2B1M',
    'Jorayal':
        'BBewl6RsooxBC8W1IqWxLmS1D6NM8S7QiHf/I7SpX7SwCrNpPsFhM9GVqEtW/X1CX1U8L1lBkTpR7G5L6I3S0I7EwIlRmK9CoIkZgQE6B4OyJcqLoR9CgGiE2Z',
    'K.I. Singh':
        'BBRuh6Ry1uxBtRuNrFhWjLvDrJ1KyI1XsBpPhI9TsH9N8XsS4ZwFyJqJH4EqIsH1L6O1BkKzOuM',
    'Purbichouki':
        'BBTqu8Rq1wxBtF5HrY9N9IrBjI4KjHnDrP5c5BlW0MpByP4L2N+EuFtYwKwFwO/NsL0BDuMoH4KG2VnQ4Q',
    'Sayal':
        'BBW2t+RkhvxBxLH/R5O1MqM3IlP4D3c9MkF9OpPiHpJ+KoLkHJbhP4F1FuH+JkMxR6JnIkNhOwGhCgS4UheqR4E0dmKmX',
  },
  'Kailali': {
    'Dhangadhi':
        'BBlBiyxRmrnxB8EoPoKwOnNsN/I1CnlB4TxG5CqD1UnM+E3O9EvNuChUwWlIjLoB/OgMnPoKsDStLiKsBsNtH9EnKsD5YkIpDyFpQyLuGoK3d6QqK4JnNqDuHmNjHJgYkH0GZsP6EoN1GkFzUlG3H6DyH6O',
    'Bhajani':
        'BBZ0ruRg7txBzNiC5T5D0CgJqBkU3PhK2CgJxJiJxSHvOhTsBlKpM7MwG9IyGsJkC3duExQyM1CmSwGwK7BiNzKgGyJkJzFqKuJiG0P/I+R',
    'Gauriganga':
        'BBmBq3yR2mqxBrQvFtLyQ4R6V6Q4BlK8P/lBiEzDlI7NGzE/JnT5CzSgEpJ3EuKvfiK8JuMzByMjexIlC2DlQ4ZpMgJ2CoNrNnKvO2GzI9NzCyN9BuDhK2LoI8C1NygB2HoJoL7ByHrKpCrfiShGwf8QsI8D4KhK8F',
    'Ghodaghodi':
        'BBa4kxRivuxB1WqFhDrN7ejB3K5K/VgCS1QgJ9RrI3SiBjsB0DmIiKhMsF4NmRgH0S/DoT6C0EgK8NF0DmI+ftE2Q0B0H2kBjPib9F0X5PlKtNqJ',
    'Godawari':
        'BBiBi5zR2wnxBnJnLxgB1H7C2N1LnItDiK9O7F5EkGxH5O4H5D0UmG2GjF5EnNarPjHzGK/XgIoH2U9S+b3O4ZmHoQ1H8JjRudsNqFzDuC4WvJ4E5N2B9FuKyByOL0X9GhCvNkX5DsShW2C',
    'Lamki Chuha':
        'BBU4xvR60zxBxT5LvG7c1JhPpC9LqChP8IxPxB/TpJ5JjCxOolBxB0SkNmTgB4MuPnB+M3HsEuJ4UreulBnLsF4B4N',
    'Tikapur':
        'BBSijtR2pxxBrNlJpS3X3JjPzL9C1S1Q3IkF6LpUjJxB0K3J0H0K6G7M0UkOgLoDsUsCgDmiBsQQhBkd',
    'Bardagoriya':
        'BBNi1wR6yvxBpTjBzSjNrS1BmE5IczKxF7Q8PqH8ekB4HiJ0YqBiNiSpT0E',
    'Chure':
        'BBnB4r1Rq7qxB1T4PxGzFjKwD3InJpNzD/VlM7FzO2GzG7D3K7QrIiGvfsfhSsKqCqK9BiW1C6DrSwNjX+GiCMzXxBxO+FtK6N1B+M3FuGyK8JX8M+GkL8JvMoW8G6LjTqR7L2lBayV3G8PjG5BnD2NjL8O3ODvHyG',
    'Janaki':
        'BBQo7uR8jzxBzWhSxL9Q/VlXyR7MiBjdrQP9CrkB0X4M8OqCuM0UyBgU7IyPpCiPqC+L2JiP',
    'Joshipur': 'BBO8gvRo9txBzEqByF8QzC+VpVYAuErdxHzN/HP1O4PiKpBjUzC/I6T6DscvD',
    'Kailari':
        'BBgByovR2nrxB7HnCrF3NhKiMzDlIb+oBrM9E9EuH/FxJhN0K3SKgF9UvD9IjJwC2DlN4PjSsFpT+I+C8DpM8JdsInHiUvWwNtC4O+EoM9EpD2UwO1BDoNyImCxMketM0BhK7J',
    'Mohanyal':
        'BBhC4xvR60zxBwIhU3B3NoLrFsetlBtJ3U4HrEoB9MzMpPiQ3KqTzEhNhSuINuNpJ6PmK+FzXkPhbzHza4DjHrOlEmK7P5Q3B3R5VuLxQkRkGoDyIgWmMqN0D4IoJkKvDyG0FyT5PyRsI3E0TpNRjHsIhCmKqHsIrEmSwD6J1N8gBnT6LtJ2KgBmK1HyJpLyIkEkOmN6L7RqIhIjDwCsN9KsT4JlGwSkDrHyDrNuR9LqFpIjKtJoM1Ma7J6I9JjDbgJ9NlClGsI',
  },
  'Kanchanpur': {
    'Bedkot':
        'BBQ+u3RmmhxB5S7C1V7B7X3P/EuB1MzdnIxM8X1O0N3Mga+JmSrFoK2IhHyDsE4OlEkN8HkS',
    'Belouri':
        'BBV85xR40gxB3LS1GgawRGjIkKrEgSjL9C1F8GzLpHjYoLjG+HnGlI3G/XsK3JsN3V+UrFmGxYoMzNkO8GhFuQ6PY',
    'Bhimdatta':
        'BBZyw3R46+wBnK1IlSsF/Z9JzN4MvbwLtDrN0JpB0H3PgJKkCxMgL3M5XX8B/NxDxO6nB0C1BkGoPyFsErB0cuHsB/Ema+JuVgZpfepM2P',
    'Krishnapur':
        'BBc87wRuhlxBiHtZ6N/lB4YwEgTuOgE2H0I1GsEjXrE/RoB9I2lBiFgJqG+kBkKsfqOiHwHrM4LhNhE7GkLtdrN7JkRnQ2H3ZlH9b4O1U+ShGhJjP+IpDtH3JoN',
    'Mahakali': 'BBJoj2R0z8wBxuB1B7U/E1J+E1UpBlCzRkItGuxB7D4kBwX',
    'Punarbas':
        'BBT87wRuhlxB3M8BtD7B7P1Wp3BsL5C0FjM/E+IxJ8K3WmXxGgKrVqN/GkYnL8HkD0C2M/KEjT8pB8PoLgWyC',
    'Shuklaphanta':
        'BBVuk3RmvjxBhHvHrfpO9kBjK/IpG1lBhF/JuD9KxJPlQuPjHmK1HsQpD6EzGgToCoFwLqPKyJ4NgHrDkWqM0YgGhNkX',
    'Beldandi': 'BBK85xR40gxB8CvM5PXmD3TyFhHL9PiT3C4JiKpD0P9M6gB',
    'Laljhadi':
        'BBUoixR4vkxB/VtC7PnLkT7pB6RvPkL+CsE/RkIjK3FvC8RrJ4R2I6HmVwKqLsEgSrEkXzI2G/D1H/StO3YvE5NgmB',
  },
};

/// Boundaries that could not be joined to a canonical roster entry by
/// name or point-in-polygon. Keyed by `districtId|geojsonName`.
const Map<String, String> kUnmatchedPalikaBoundaries = {};
