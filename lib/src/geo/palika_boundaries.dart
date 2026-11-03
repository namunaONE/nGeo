// GENERATED FILE - DO NOT EDIT.
//
// Lossless boundary geometry for local bodies (palikas) of Nepal,
// encoded as compact strings (format version 1 - see
// palika_boundary_codec.dart).
//
// Source: docs/palika-boundaries-highres.geojson (lineage in
// data/SOURCES.md).
// Coordinates quantised to 1e-4 degrees (~11 m) and stored as
// zigzag VLQ deltas: the round trip is bit-exact.
//
// Regenerate with: dart run tool/generate_palika_boundaries_highres.dart

const String kPalikaBoundaryFormatVersion = '1';

const int kPalikaBoundaryFeatureCount = 753;

/// Total boundary vertices across all features (ring closure vertices
/// are re-appended on decode and are not stored).
const int kPalikaBoundaryVertexCount = 16017;

/// Features joined to canonical roster entries.
const int kPalikaBoundaryMatchedCount = 753;

/// Encoded boundaries, keyed by district name then local-body name
/// spelling, e.g. `kPalikaBoundaries['Chitwan']?['Bharatpur']`.
const Map<String, Map<String, String>> kPalikaBoundaries = {
  'Achham': {
    'Bannigadhi Jayagadh': 'BBKg56RijzxBxCnL9ckChI+GoEuEA+9B6MI2PxQnB3lBkDtK',
    'Chaurpati':
        'BBaur8R81wxBrDvJ3X9M1ItB9G2KtIhDpPvc7BvX1FiClB2J3euMrWoZoHuUoR+UoHsQhDyD0N8HgR5EZjN4EtD8PmJEnV8LkCyJ5YmN/B6J2K',
    'Dhakari':
        'BBRsr3Rw7yxB3HtdlHrFZrdlUNzK1PqCrIzHf9ByK1dsnB3Fme0FoKnH+LsNySmR0EiWyT0Lc',
    'Kamal Bazar':
        'BBQq24Rw90xByEvEnH5IuF7T9azBrKzdpKQhYmxBgL4czJwZsKkHuLnQ0Q6BnDzHwQ7MwTlC',
    'Mangalsen':
        'BBVm15Rq90xBQ/3BzEvFkErN5EpOzI3DiDzD9Mla1LrLlFvT1K2BxC+L9JvElawOasd6JwLmDsZqKPsK0d+a0B1D0Z',
    'Mellekh':
        'BBPi48Rwi0xBjJjJ3EtU5VnUhGa1HgW3F/JvNyGvDwrBkSykBmNyLuM+DyDnLiK/F3K/T',
    'Panchdebal Binayak':
        'BBSi55Rwx3xBpC/OjSzQiI3I3C5G9KlDlBnYxRfpWmQoD0HzQ5BvK+N4fwc8HqZkW4iB2G7S+JzGT/P',
    'Ramaroshan':
        'BBSsg8Rs22xBpFvShZ3PxQjgBtQgQ3exMjMoG4IyKE8W+KmD4C6GhI4IkS0QqCgPoRnDwQiDuH8HuLhD',
    'Sanphebagar':
        'BBe8s9RiwyxB3BnJlH8CmEvb7JjB1IsL3BpM1OrBoGtStOlKjRuFzFsV1LrCJwV7PlJ3EuDakN/WgC6FkN3DqOiI9G+cjC6DmL0GvF4D0K2JzWgHHuV+XgPhKwGuD',
    'Turmakhand':
        'BBdm42R811xBmErKhFhVlSxDhWxTnQzF7LwZzKgH2B4QqNkZvMif7ZTrHgRpM6EtLmPhOrE9LoMrHtJgE6kBiPU+KrO05B9d4C7K2V1PoH1NqLNBhI6X/MgGqF',
  },
  'Arghakhanchi': {
    'Bhumikasthan':
        'BBf4pkR+/0yBoKlB9W/RnHrC/BmGtLyDtI3B9HjN9JudnN2KtV7BlC4JxHqCmF8PvF4PgHuagM8B7E7D8FvF0HgEwInQoGfyBlK2KxB8B3L8NmJiH/HB4JyH9CuLliBiJzD',
    'Chhatradev':
        'BBPuwkRq34yBGxEpVsM5M1PlQ7BpQ0Y9YmGVifsK8TmJLH3MsN9KnBvGoV7LkRpC',
    'Malarani':
        'BBU+hlR4l1yB/XhGhS+rB1I4EiG0O5MsWyKgPvEiL6M2PqVlMpP/RgG1PuJCvEtO6KnCrC9P2L7CiBpMpGpClB7J',
    'Panini':
        'BBYk8hRgz4yBoEtG5T1ExC6K1N2F9EpF7MsHvE+KzSrIrK2E8JscjD2YuPgOmF9FIyKqJiIsVrUuLuGHxR8P2G/JlN4ClRvFlGkJ1I',
    'Sandhikharka':
        'BBcq0jRk/2yBlFvYlHgIjOnJ7B4L1KyBxBmKnGgBvIoQlI7DpFsF8E8DpEHhLpH/M8MwIuMrIuDVsK+EqFwNxF4C9K6T2EzF6eiThFwPlYkVbS7IxK/O',
    'Shitaganga':
        'BBzB2vhRuk1yBmBjlB5Q/QoG9MjIpLqF9FnF9L4ChPzQ5L5GoC1BzKhF0J3NngB1HxE7RsYmHmEtHoDHm+B5FsTiHoT3BsWsRwOzGnCphB4WiJsXqHmCxIkEzEwNuEsDpJ4kB4FgZvH+M0TyH6EpIqLyB4JjM1G9LkDlG+IxCuR6I6FxLoN1HG7JsItDzInM2FRkI9OpEpSwF3PnFzP0HxC',
  },
  'Baglung': {
    'Badigad':
        'BBb61pRmh7yBnTlzB6EhJ3MvJlJ7RkGnHhRziB9JnCQoT3EgE+MuPhI2HgI0K9zBy3ByBkF8K8FwDoWqHuGyLjD+EhIuISqElQ2P1HHkHmIyB8DyIgO2E',
    'Baglung':
        'BBW8hpRojgzBrI5RnMM7H8J8G4F9F8B3FrBtHvQnNgPvIpCZpGxJiCoE0e8I4J5MxD8BoIjMmN0BkGqLwM6PlCiSrkB0YnF',
    'Bareng': 'BBN2tmRw09yB/I7dta8UuEwfpIIxDqHwIqPzGqc6FL0F7MyWvE6E7JhD3nB',
    'Dhorpatan':
        'BBX6lsR2l3yB4CzI1JzOyHzblH9MjF4G9MsB7yBw/BtOEtF0WjPwLqD2L4MwJ5EiJyT8yBqMvLjD9NwF5WuM9KpNzJvDvN8D1Gw+BpH',
    'Galkot':
        'BBayvpRwq7yB7Z1PHzH1P2HpEmQtIR9EiIzLkDnHtGvDnW7K7FyEguBhVmSmLsbjFoMoBunBgR2B0FzK4ThMO9RkNjKhGnGoKxQvCvLuSvR8W3K',
    'Jaimini':
        'BBS6lnRuihzBxI9J1Exd6JpF3HxR1IzC/FCnL4PjRCnF2M1LBnS+P2UiPuQwV8IrD0UyIgMhQ1B7I',
    'Kathekhola':
        'BBR2mpRm6+yBvF9L9JmC3T9K1MyCxWsR3FmOgMqZgNhF0FtKuHwQ4FsB+F7B7G3F8H7JyKyC8H/F',
    'Nisikhola':
        'BBTonsRu9yyB/CpGnNyExL0R3ToB1CkR9X+GN8P3QiPrJ8jBvcyWyRqiB/DkL8SlJ6FjXoJsC2KrHgtBj6BgStH',
    'Tamankhola':
        'BBS87sRmu5yBpKjoB7OyB5EhGv5BoG9D4GwDwNqN0JtM+KpFoc8JoJ+H3CgOkJsJ9NyHnB+CkLqJoG+TxQ',
    'Tarakhola':
        'BBSojqR477yB3K9b9L+SjkB8VlFsGuC6LzJ4JV4JmGgDjNkKyCyMgNvCoT+K6NKuE1Y+RjUrB1UwJ7I',
  },
  'Baitadi': {
    'Dasharathchand':
        'BBewviSoijxB3ClN9gBpYyB5JvESpCpNhHb1FuKzFhG5GgQlHiCeoRvLsJ+E+O3KGlDtFzBuI6EuRwGtCqF2H/F2O+Q/FuG+GyPvQgOzDwGnR1CtIyM7B+D3GiGgM',
    'Dilasaini':
        'BBbqlkS+ppxBMprBlLlJ5DpO8FnL9BtlBpe3qBM+oBhOocmE4WzGgEiTiDiIwLoMlF3EyL+G8BxBmKzImM8BqE2FjEIkF3IuOqCiKmJ0CrB8FsGqCuHlI',
    'Dogada Kedar':
        'BBRy8iSuykxBvJ/MWtcxJpF3EnLvE2GxM8B2CuI5G4NmEgRpUwP6H8PvDqXqRJ+G4Q8R8BkOxc',
    'Melauli':
        'BBayggSqljxBvQn7BzFvC3EuGqFqP1VHlD9FzGsNzN1M5GyC1MvGnEqEmIuS5CsI8KW+L4J/DoGiToXuFnG0K0EgE8KsN7F6DqD+FlJ3GwBxDpZ',
    'Pancheshwor':
        'BBdyxgS2vhxB0C/FpIjE5GlRnJXsCtKpIhG/OgI2EvOlCtEtDmDxChTlVpBhMgVlNnCR2HgOyJ9FkQoHgDEkLqIQmC1G8G+JkP4FkGlL0FwCmN6qB8J7HlB1Q',
    'Patan':
        'BBlBomgSszkxB6KzG1E7E3QgGgGpOzDjHrHmJ5DpD5LmGzFnL5KzE9EsG/C9HxD0DxGxItC+D/D6JmImOxDqVwDiHsM0ClEiP1JuDEwV3IuV4LyR4KjGmDsFjD4Z6R7cgV8B0FpG9DzZkMvOuBrP+FL5FpH',
    'Puchaundi':
        'BBbg1jSkkoxBlGxD4ExLnMmFhIvLhThD0G/DnEtW7R7B9G3QpRKqBiU5HqD+IsjB1O+aOiPkOAbsO4fyJoTxDwF+FoD3RiJWuI5NC/F3FiE7B/E',
    'Shivanath':
        'BBV2n/Rq9hxB0EhE1FxHjRvElHjKlC2GpIPDjLnH/C+FjQ/NxJS1HzZmMxM4SwR6fkKzE2MwG6GxC0N2M0GrNmD+F',
    'Sigas':
        'BBY85gSygpxBf/OpYnNvBxUzFqG/U7B/K6X7MoH1Fqc5IlDlM6Ob+RoK8M7C0JsM8FgH/EgDwOkS0Ua1PsN7EiD7LmdzYzF9RqK5E',
    'Surnaya':
        'BBVq0hS8mkxB3DlM7MmDzKkO7SuH0Ckd6FqH9FMpBkP9ImGrDgRkF4EMghBqUkP6JvGmIpT9IrjBmJvItDxWoEzP5H7P',
  },
  'Bajhang': {
    'Bitthadchir':
        'BBQ4uhS6yqxB/HlvBjOAzEmUpK6E0F+Rld0YhD8LrN8EZ2PsP3H6QQ6KvMkNkB+IlMI/P',
    'Bungal':
        'BBoBg3mSu0vxBpE7HppB9FtM7R4D/GvEnUhMhIwIhWlS/uB7LlPUxbvGxCezG1I5BnC5JhJT5DiS9EnGzMqEzfhHkDocxNqHzB4K2S+LnGwHrGzFb8NwHyIMoL4IgH9C6H2FmRyXiLuGuR8diKwMiOhF0LsI2FknBIgawI',
    'Chhabis Pathibhara':
        'BBS20iS24uxBH7V5WrK/d0U/PmTtQe2I0xB2FIuEzI2C2E8E9F4G+EmFxGgJU+G3NuLtGQlToNJ',
    'Durgathali':
        'BBO2giSi4txBxH/EjFtPvD+Fzc2H9CoIhOjG7FuFoF2HnJkMMsRiE0FgPxBmT/U',
    'Jayaprithvi':
        'BBe65iSw4xxBnIzT3LSjQ9OyDhDtEpJpPxClFyG3G9E7E+F3DpErDoI1FHkB0I1N+O/FiUmCuKhGgL2HgQN0fkcjqB4N7KmEnNmEqJoM+F8IxKmLgDoG5N4B4JuFP',
    'Kanda':
        'BB2B6/qSm5vxBtYtgBvVtO3NkElOjM9HQxKuPtPmI9ZFlIsOkF4MhRsM8KqSlPsgBrhB8PpQ4X+G0G0B0dtG0F9P3BhQ4VwBglB7K2nB+M2csNXiGkGkUhK2GkD/DyQwE8HoKkFgP1IwJqHgakEiU9T4GlR5C5V2G1I4M2D8SnG4N+KsRlI0N7iB3JjMkCxP2Vl1BrIxVjF8J7HhFrCnR4JjOvHxGO9VuF7P',
    'Kedarsyun':
        'BBZyzhS6+sxB6C3E3I/GLnLvHxIc7N0F0F8G7FnGjGnN3BzG4LjNjB5KwM5QPnNmJ4GgBsFoLhBwhB+L0SoI9IxD5KsK9C8H4G+CnI0c1H',
    'Khaptad Chhanna':
        'BBVumgSw9wxBgBlM5FgDXvIzShUGuS9GKxF6IjHpIhDiYtHgHqIsS/KiU2B6N6MuGqQwc4LjS3GnbiG/KlCtKgGhU',
    'Masta': 'BBKimiSsozxBvCnOzYxPlEpJlEoN3N8KjckqBsoBuiBuQ1PoO9sB',
    'Surma':
        'BBYummS20wxB6IlGpJ3M/ZvIjnBHrI1FqFzK9HtKnfrPnLoR9NWPmTtLuGxGoN8H2EhBkKwNiIrCqEgToE6F0L/BiS8ZuH2X3KoZhe',
    'Talkot':
        'BBiB0vmSk4wxBLzJ9egT7N+BhZ+dnMqCpF6HpkBvG3B/JvG+NlL/CtMsK+P6J4EoNxI+BjNkrBjR6P4H+VwQ2B8I6KgXkBwR2bmC9aoGzJrElQqD5V0P3U+P4B0G/F5Bnd7G5GoQxXohB3P4DrQ',
    'Thalara':
        'BBQwmgSquwxBnEnjB7IhNUxU9LzSkBphBtFtLpJG/a8Q2B2TkMyhB8LwIwFoY2HNgV4bK8H',
  },
  'Bajura': {
    'Badimalika':
        'BBUi4gSk14xBjErVlH/H2Dlb3VrL1K8C9HzW3HhCjTqJsLhK5FlK1qBwkBtBkwBuHyY8b2HiMuM8KsB2N5KiS+DqO7Z',
    'Budhiganga':
        'BBOoz+R+t1xB9GpUxL3E+D3I7TjHnClO+H7KnRvIZ8G1KlLjQsJqF8QyX2Rud2rB',
    'Budhinanda':
        'BBVsnjSm64xBiD/DlnB9F/V0WvP1T5OZpO8ZhS9D1N6KrNtE5D8NmdsZgEgcsJuIzE6E6OsBuJlDwElJycjLqc92BgM/C',
    'Gaumul':
        'BBZgvjSi04xB+L3F2CvH5OlP9O/qBnd9FjN3MxLezFpS1b9TtI/OxHnCnC7LrEkBlP4buH0GGgpByFiQ2K7C4VsL1DmbsLoakV8UgWzW6c2H',
    'Himali':
        'BByBk5oSo17xBkF3GzF7N8E1MhGrLiDxIlItGmEhLxIlWNxUpLInGhHnKyWzQyO9ZjEvJpH/O2InKjFvE7HgExQrHpDtToKhGjG5FuCnCqJ1c0R/GmP3L2Cxco3BxckLpGqK1WmBgJ8F6MojB2esLgY1FkGlMC5U8M/QqJtG2WvB8iB4SqkB8H2DoVyFmEkUKgGsIsgBqDwGlMf/nB',
    'Jagannath':
        'BBR0w/Ri77xB4E0E8EpFrJtI/D/blVxW/GS0B/V9TrJ3VfgMqjBtJsQvV+C1CwN8K8rB+E8D6UzO',
    'Khaptad Chhededaha':
        'BBVwr/R0i0xBrP7d5MtGhBtPhZ5V3L2hB1JqJ2EoGa7GoRwI9H8KoCmOwS0FxCoKyN4HoKgevKyKoS5JwLuExB5kBtHzG',
    'Swami Kartik': 'BBJ0ngSmg9xBnJzaxQtLl2B2K5U0O4bmJyB0RiqB6LqbzM',
    'Tribeni':
        'BBQyl+Rs51xBnNrZ3hB1hBjF4Q9SqPK0HsL2JlQ4V0GsQ3J0P6E8J8ViPMgKubkW3GtZuBjwB',
  },
  'Banke': {
    'Baijanath':
        'BBgB+gpRqt8xBiMxVgC5RpGkLzIhIsFhB7VlJiEtF7I9HrIiE9K1V/H3D2CzKjO3KCrGvGJpHvUlTvF1E6FuG+GfgKkGMgJ+RnOiNpJvHtE4C4G4PugB4FgC4TqLwGgF+QoYoG',
    'Duduwa':
        'BBakolRy+7xBjI9QzKgCpD1EnD8EtE9J1FqFjJvDvG2GxH7FzG2GnGhCzG/IuUtOrR/MtI4sBhd2kB6I6E4DtI+VTEhTkNgL6RKwJjNgVoLtBhF',
    'Janaki':
        'BBSs3lRs96xBrM9mB3T1MhB1M/MuIsCnM9F6FnC9M9FjBhS8e2d8BrEmRsKiDuIuOiK5HiDqVmJoD4BpG',
    'Khajura':
        'BBc0ymRov5xB1IlSjGLgB/JtG9G0EjG9E0B5GpO5RoBlGkGhC3ExMsNnF/MpEUzJuU+FkBX+JkDiD8DvIoCmQqK1JR0KsV2OiLib6K/ChKjXyE5CqJwH',
    'Kohalpur':
        'BBV0/oR2x8xB5HnMrnBtN/E9QpLvG/B3TviBzF0EgK3Ka8CyLzJuCaiOtG4DfuJwoB6UkTub2U+G4PyU2EtN1F5I+M7D',
    'Narainapur':
        'BBN03iR0k+xBzD3K7J/ElB3dxI6H5I5E90BowC4BuZgKNsZmV4MTyJ3gBiU/V',
    'Nepalgunj':
        'BBa4ulRyu7xBjDzNvFgCxElH0EhJzEhGhK6HtItOrKhDsElR1d7BzO0X2RmOtUuO0GgJoGiC0G1GyH8FwG1GkJwD2FpFuE+JoD7EyG+E2EnE8J4L',
    'Rapti Sonari':
        'BBnBunoRoo+xB7O1V5UhHjTtb1lBlS3UqJuBiFjQ/LrO8NlRBnI3K/GM2B8RtRyBhCuFqFqC7BsWkQyO7JuSyB+KhUgWtG6d1LiF6DsSrEyvB4SkBlCwfuI4I1F0kBoxBbwZh0B0Q/1B0YhDgYzTmUnkB8KlDuKlY/C3NmKM',
  },
  'Bara': {
    'Aadarsha Kotwal':
        'BBRmkvQst/zB3FzGChTpO+ItG1SxQjF+D9E7D7CxKmDgPwS2D4S5MOtBiN+F3DwHwFkFvJkEwH',
    'Baragadhi':
        'BBOk7vQ2x/zBhD3TlLgFkB9HwOpEzF3YrF0H5ZDpJuFyByRyO3ICuTgR0S8KrC',
    'Bishrampur': 'BBIi3vQk16zBWnH9Wxc7IoQrDwgBqJckCxSyL5C',
    'Devtal': 'BBMkgvQmo8zBrT9DhH5EiBhGlQzIrCwT0LM3B0VuJqB+H3PoBoL+HsD',
    'Jitpur Simara':
        'BBgBgv2Qij8zBzI7SzTsBjL1GpTiL7iCxTlXuGzJrItLZ5FhKhLgH6HiKvBgOlIgF+D6P4c2PjIqNhGO4G6LpJnHzIoBJ0G6M0MuL9H4f0BuC3HkbxEge9WiMgDgOkNklBhG1E/Y',
    'Kalaiya':
        'BBawyxQu68zBjc/Qnb5nB5DkN/JpDOyFlJuF5J3JkD3JtJpBvDgOpNqHkJqNiT8C+C4O4M2E4ClGmDqKuN2HEoHuW6DM7EyIjBqJoH3G5LiGN',
    'Karaiyamai':
        'BBSg8wQo89zBK/HvO/H5KsB9DhKzG6WpOvErEqHrPsBqB8GiM6DwO/DyErHkH0aoL5GyNyH0FhJ5F7E',
    'Kolhabi':
        'BBW07yQ8v/zBnNj4B1cItL+H9JhOzEmnBvOrHpbyJSwJwGnHgF8ErBgK6E0B9EyQmF4B6EzM6B8OqG7CPpIgK8KyX1CyIoG',
    'Mahagadhimai':
        'BBT++vQ0j9zBvJ9E3D5KlC2G3M1E5F9K9GsPxGvOtJsQ4G6EvFuHoNiE7PpDxE8OyUoJyH9GyJ6CsEpH2J4G',
    'Nijagadh':
        'BBWiu2Qwq9zB7BhKjlBiGzZnQteiXjbyExC4MqKoxBtnB+VsF6I6UqQ4mB+JsDuF2BnImMpJnCvf2K5WgN/GmGvL0P/FkJ1NiPnC',
    'Pacharauta':
        'BBR83uQ2k+zBrS1M/NG1EnOrOhFX4FzGrT3MxElB+oBuIhBkQgL6ClJ4OU8D8CvEuEkR0FmB+F',
    'Parawanipur': 'BBIi7wQ2o7zB1GhL+DnMrYzLKgK2KyD5GmSuOoI',
    'Pheta': 'BBKi+vQoi7zB7FpMvMrI1L6CnFqc6J4JmJtFNxF4JyDkBlK',
    'Prasauni': 'BBLw6wQgw7zBrWvK0BtHmEqBLzNlSnEPuLmMyOGsM8SgR1DnL',
    'Simroungadh': 'BBL67tQ6m/zByFlB1D9SlQ9U5F6HvO1ICq2BsMnIgCqHoLa2BlN',
    'Subarna': 'BBMw0uQwr9zB1MpC+ElIrQ7HuDxU3Q8Bb/FvI6lBuN+DI8I8IoIiI9R',
  },
  'Bardiya': {
    'Badhaiyatal':
        'BBhB+tnR661xBPzGtI3BnFoQzWhBxIsWvMmClOqVpWvDvIyQuELE2IgFiEyMrNiC4EmGjGuRtBsH2OyNzCqC8G8HR6HgV0JhEpB3E2EkDuCxGnJhLyBrP7F9EuDlLkIxBpKvH/BpY',
    'Bansgadhi':
        'CBekipRgz3xBIvGvUnLrJrOhHYgBzHrPnBlJ/H9GmFgCqYqKwHjIyBnD+M2FmDxBsPoJiL1MqMyRmR1C0KgI4DiL4VoIjEwJ4G+ExUhK1OWpLiKxJ1E9IsGlLpDrJBOm7Bu0DsFzF9EsCrGxHawIjI3B3CqL7LZPpRhIjG/B6RnJ4J/DkRyjBwN',
    'Barbardiya':
        'BBa0lqRyh2xB6HzOmQxH8GmDhF9XvLvM7O5DnDvJrUgH5U3EtI1I3LycuB6O5KgD1C8HtHjE7D6VpHuEqJgIsPoBf0HiHXigBsfsQtIjDnUoO3I',
    'Geruwa':
        'BBQk1sRwsyxB+jB+OkWWzrBjyBlO9EnDlJa4JnL2DrDoH5IgCpL/InVsLuC6NmWjG8N4L8HvE',
    'Gulariya':
        'BBV4uoRq4zxBnNiE3SjMvXiZ3RO1BlMjLsQhH5HsD8iBmIuEkGlHoH8ElB0WsWeiFlQ+I0BmDzLuHkE2C7H6K/CtB5O',
    'Madhuwan':
        'BBVsqrRs9yxB0DtD9I7IGjN1ViDjQpNvD0MhVoNnWjB7hB6d4SkM8O/FoI2IiX2EyN/EiJvLiGsB6GvT6HoB8CnFyIuF',
    'Rajapur': 'BBLuysR4ixxBpY1oBlfjUrO+MjN6mC6QqNkNnEtC5N6HjHuNnEsMkJ',
    'Thakurbaba':
        'BBYq/sR8v0xBAlRpHlJ5X1SpHc1DhFiK7CpZnQ2GwQlGyGxItF7CoF5HnB5GwThGrBnGkJgF+J6R+F0LqQgLzJsIuEoIrOkJ8LkDjH',
  },
  'Bhaktapur': {
    'Bhaktapur': 'BBE268Qi9k0B7GnIvD7VtGoa',
    'Changunarayan':
        'BBNsy9Q+pm0BhIjc2HpWzClL5MzP3L0CxEqEmB0P4H6J5Q3DhE+e0TmH+CqL',
    'Madhyapur Thimi': 'BBEsi9Q45j0B3MzVlJlDoGuhB',
    'Suryabinayak': 'BBH4v8Qihk0BD9XnH3C9ZmkB2KkWlH6FmRgT',
  },
  'Bhojpur': {
    'Aamchowk':
        'BBU0qwQ8yi1B0EhC/FxGrR7FnIgO5NpGrH4Jzc3EvOtImBoQzG6B9FyNiN2Y0B6fsIgPqH5MsbEkc3X9FpO2S/V',
    'Arun': 'BBN+w0Qium1B5FtU7iB1L1EmdndyD9Y8fsB4G2Vib0Tc0K9PkQ9F+R3VmF4B',
    'Bhojpur':
        'BBTgw0Qkyk1BuK9J1NjLuF9JtI1C1ClMzOnH5rB8VhXmWoB0N/PwPgOxDsH8F0PjB0LlH8Q8H1B0GknBwOpEjY',
    'Hatuwagadhi':
        'BBQ84wQ87l1B7ElfhRjGjJnLjc4X1bE/GyM+B+S1G6F8IqB+ElGmFkIgNVga8XgWtJ2DrN',
    'Pauwa Dunma':
        'BBQ8mzQk9l1BuBhVhL9F1JtC3H2HzPkBjEtFhQyC7NqL7C2PpNwL1DoNoTA8TmV+Y7fidrD',
    'Ramprasad Rai':
        'BBO4myQ64j1B/P10B7NhRnIoSlXsOtCwS5I2FzKmWsPwUiRkGgFiY0X7VmGlInBzN',
    'Salpa Silichho':
        'BBV8r4Qyrl1BtBzX7LtJsEnJtH/TwOzrBhKvEhG9QlQ4CpO2MzJ/DhgByb3H0LuCgOkZ4NqE3F0SiD+UwuB1E8P0J1BsMiK',
    'Shadananda':
        'BBSmx3Qmul1B3Up2BzShDpE4FvXhMrPuXtGfzGqJjI0W8HipBrHuZ6FlFsC8HwVnF8IhM4WqGwajmBgMhC',
    'Tyamke Maiyum':
        'BBW6r1Q2yj1BF9U5HnMvS9KMtWzK3K9Q6UvNQ1TnKjIoGnRxD3I9NhLiOgP8QmRy0BwwB1b0PsI2BiLwI8CvF4J0LiIoGa',
  },
  'Chitwan': {
    'Bharatpur':
        'BBtBmu/Qo4xzBvHlW9PRlIqSjMkHkDtNpKtIdrJ1WgF5O9fuN7RjEjNrTlJxH9X/W5ZhShjBzOtL1DwM0KkUjMwLwFsJpD+c8DoG5I+MkLoVrHyToHiFK0RtHmG+J+JfyMkHjDjCmHkGkF6ZpE0B6G8iBzI2NgGmHoTmRmGmM1GiKsF4L3FmDjM+GY',
    'Ichchhakamana':
        'BBhBqxgR030zBzFrHmFjLtDrG3GzCvD9K7NnCjC5UjK/C+C9M7GZnDmMzL4FpJvFhN6GnLhFqCqQjFdsH+N0R0E1DsGwH+PvW0SvEkX0E5C0MkH4EhI+H8D4ChX2K6E4FhRgJmcyKM',
    'Kalika':
        'BBY8q+Q8z0zBBrazRzEvHnOoFoBjC3P9IvErEtQ/NhG/MuCzD4D+FyNlKoKuIkEwH8QtEiP+FwEoCuRzP0RsK8G8B4P6YuHyKrVF/M',
    'Khairhani':
        'BBTi38Qmn0zB9G9HiCjOnY9C1LrMzJ0IV9K5HwK7J/TpK0E9F3FXuakLkKkEwsBM/I0LtD0EpL6S5Kod0I',
    'Madi':
        'BBYip5Qg5tzBgDrClSDtI0F9MpJ3VgPvMjB1G0JuDwF7Ng5BoB8evJwS2EoDvCmGgImBkGmK+CoWoQ9XsE9coMrNqHreoW7kBG3OkIvD',
    'Rapti':
        'BBY629Qys3zBxGvlB5ajJrCpQrK7GsP3QxBtNpFuDndzI5S6KzEqLzLuDgF0azKiV6K0PkOkF0W3MkKyIF8InFjB+F2O4SsPoD3D8JyG',
    'Ratnanagar':
        'BBX608QizzzB3H5TtIjEmKnKjG9P3R8EzB5GrRDtIuEjGjFkClH5DsE3E7DoHyM3QgHtD6JkFsFkLnE8JgU6HvKW+K0JzI2LsM',
  },
  'Dadeldhura': {
    'Aalital':
        'BBc0g7R03jxBlClJpQpH5Q6ItQnRtgB9CnH0FjTvHkC6KhJwatYmDfvI1GhDnCqS+MwV8JZgZkRuM5SiKjDoIiZ+PCmCqPuJU+OkRkXxM0BvTmF9DzFhU',
    'Ajayameru':
        'BBUuy+RqplxBnM7CnE9JqEtSlIlOuG3NlGtKgEnGhbzRvP6kBqE8N5NmJ4FmNrFuEkGkJ5FmGwTmame2SiE9Z2JtD',
    'Amargadhi':
        'BBU419Rm3mxB+KzBnnB1bnIxT9LyFhKlcjNgDsB1MnPtKhGggB0F0TlF+DtC6UyJuDgb6fwI7CsCoKgJ3EiIpagT2G',
    'Bhageshwor':
        'BBays9RirixB/EnVpH2ChHjG2EtF3NjMW1KvzBvQpJwCjI2LmHwlB2JoMsE1EuJuC3Ko3B0PuLrB2MuNzC4J6bwPtJjGjJsFtE3FlN6NlJzCrVkNtc',
    'Ganyapdhura':
        'BBPsw8R29oxB8DjB3Izc8D/HlKzPzI4CrhB5iB1PoC7OkKyI0zBsYuB0ImUgOiLqPjPgKsM',
    'Nawadurga':
        'BBU+0+R2+nxBjC1M/KiG3LxRyD/O/T2C/S1G7MweuEqK5D2O8HyR1KkW0IwCmIhKsL5BuKuD5DyEoI4JuJ1O2IsD',
    'Parashuram':
        'BBoBuq7R8rixBXzJ9MqD1JnMpH/kBoIlMhNjD8PnapLnEtJ2KvNIjO8ItPvY4LzenfgBrM2PrGKvH4K6EuQtE+K+H2R5Cyd/F2E2B8T9MwU8G0Y1L6FN2FxGbG+HoZzCiJvajC5KkTwH+GzFiYa0P6FwJyN6Q5IyS2K',
  },
  'Dailekh': {
    'Aathbis':
        'BBU+h5R+q5xB/b5qBjI5ZjmB3hBhIoCxExFpL6JvHpBjG2F2BsG/Le7R+U6MyX0CvFkP+ImJxVoQ1C4Iga8TmL+D0N',
    'Bhagawatimai':
        'BBTuj0Rwk/xBhD5JhiBrcnCzShIvHkClcnMwD7FsNrMuC5H0R5M6D/EqJ8MwR6DobuJwCsL6RuU3O2WtGqQgH',
    'Bhairabi':
        'BBX8r3Ryv7xB7F1XkE5MxHnKvFsEtR3D9G4GntB3QrH9E8F7CpIxD5F4PoDgO7KtD7LwItLia0G6EiiB7V0XqI0RxJwPkC0DuQ6SyP',
    'Chamunda Bindrasaini':
        'BBPuo2Rml6xB2FlKtOrQ1BhQhTlL/U1jB3FoD/HgQvNyKqTqKoE2SzEyFsI2D9F4C00B2V',
    'Dullu':
        'BBPiy0R+m5xBhEjTnTlMpsBsVxLyOyE+JpP2b0FqX2b8GyFhI+J2BsLja8LvI8KuDnD/N',
    'Dungeshwor':
        'BBRk2yRgo8xBpF5FuBjUhR9CnKhQ9LrFxOoCuC6X3OoVwDoUsI+FjCgHiGoI0PnBiI7RsMtC8FrN',
    'Gurans':
        'BBYwnyRg15xBzEtJtOZpEnU7W+RpDoQ5KuJuBuI5J8F2BwWxVopBpFoa6JRsR0RuYyC6FpNjJtKkCjHnGdzFnZ4OnVtC5XwNzCgN4F',
    'Mahabu':
        'BBR4g3R447xB5SxPtDnQrHzBjND5MgJ5Z5HpeiU8L8OiQfyMuQ4LzC8I0IuIxEmC9IsXwHmE0H',
    'Narayan':
        'BBSqu1Rm+8xBhDrS1RhBnMpQlQgB9L7O7MnFpKiI1HtBvBoUuHuKnEyXgIqHqHoWkRhlBsX0IiJ9KkSsJ',
    'Naumule':
        'BBWg42Rsk9xB9G/YnYjIlC+IvIyE+BgM7IgH1PpJzL8KtXzIvP0pB6b6UuB4Q4M4DqO4S4hBzC2FrG1JhXUnP4HnS6MlQoFmB',
    'Thantikandh':
        'BBNst3Rsj5xB5C3P7TlL3I/ZnQ2ClJyV5P1IoGsRsT0LsB0PqNkNAqKiU2B',
  },
  'Dang': {
    'Babai':
        'BBc0soR0vgyBnI/HvQ8M9G1QnHpDtjBqwBnSqM9V+B9NkoBwUmJgViXqEsQ2HrH4VN6hBoM/ItQgJ7G0EhU1NhUwCpK/Y9VoMlPqBzMiM3FYuH2JyF7B/IuMjG',
    'Bangalachuli':
        'BBZq2kRoqtyBhR7T1FvenM8O/Bod/NyH5CmL9PlOxPiI/T3PrJ66ByGqStI0iBhHoFmQjD6CgEkLjP+LmJ4IlCrBjK2JlD2Pvc+IciLuNkOr6B',
    'Dangisharan':
        'BBSgylR+vlyBgN7F/RvL9KW7E1JwK5blRzQ7IAtU80BzU0byJsH8GlImFqL8M9TsW4d0K2CLxcqFuC',
    'Gadhawa':
        'BBZ23/QmyryB7BrT/boJxQjE9GoFtHjJpNkBnCxJlZ5C4P+/CuMqc9E2EuB+UiZ1FmB6Q+K0HcmdhFgBsH0NsPxG9G5EiS1YlDhkCsBvSmJvK',
    'Ghorahi':
        'BBlBg5lR2jqyByClFnQrE9F7UvasBrNniBvS9BrDqNxLrJpEmKxRjOjTymB1EghBzNuXoKgLnCyLlGYyDwNhJ2GLmI4O5F0G4XkP0JmMtJiTwP8ClLgOxHgCndoM7O2FweyVgQqJ9RgNnG1CpLoL9VjMjM0IpD',
    'Lamahi':
        'BBhB6tjRmslyBxdrD5kBsiBoJyJnHkD9HqY3K4L5DwnBlKgEEoLnH8ICyXxQqNmF+LnGkRoDs1B4G9C8LmIufuCgG5mB3K7E1HuGtBtEoK1JlDtOmGXmC/KlKxL4NzXyE5gBoWh1BiQtVe9N',
    'Rajpur':
        'BBei/hRu4lyBgOjOrOJ2FzkBtI3IuChf5Q9C9lBukBtE2QmFuCtO+hBhsB47B3SynB5YyVlQ6nBmZ6CoCyJqNjBuHkJ+GnFyQkE6VtG+UzMiIrtBwK7E0D5mB4K3L+HpYoHjDnJxJ',
    'Rapti':
        'BBRkphRgwvyBtFjS+C7jB1c7B7LlI3G+CnD1J9H+EoB03C2HyEgOsgBmE1J+DqLsG9LuGJkB5J0IzF',
    'Shantinagar':
        'BBR43nRq/kyBrgBpP3VO1HsHpErQ9N1NxI4N2CwXmLNgSwL9M4F7GyLyf+O0XiGoO7FsHtQlE9L',
    'Tulsipur':
        'BBf+2nRignyBnGzVpO+FzXhG7dxN/E9IG6clJ3B7X1e5M+TlFpL7GmIxJrHlL8kB5T0hBiSsQuEjKyLsJsDpNwS+BsNoiBkY1CmHqFyBwRwQuEuJtVyMpCMhQiVtSFzPkOvH',
  },
  'Darchula': {
    'Apihimal':
        'BBkB05pSwvrxBjZjGlG7W5XtN0P7VvCjT1d+GoCzMtEvDrTyRpGArGjNvSoFlMmgB8F4QnFlD7E0KmH+MoLxEGqE7Xy2BgCiWpNoLwEoU3DgHwJyPosBoI2HzS0ZQuPlIsN7QqTiN4JXuIhanE/OjK1H',
    'Byas':
        'BBsByvuSgzuxB0IjZvF5H7ChhB7nBzlBja0IrH9TtL1E/E5TzUtQvErL5avI/D1R5Z7Z7BpS6F3LxHxVvSlNhO3BwV+djIqN7ciXxEgWmI+InC0MsetG6B0SzP8V6XuNmG8WkZyD1RkwBwNkQ5BohB4TqKuYghB8TkL4IvGK1K6dmBoUvYoKtGmImHkGhK',
    'Duhun': 'BBJ8/nSknnxBiPnI+FvO5UnbzTlJ9IqLnEsrBmHAyJ0V',
    'Lekam':
        'BBQwokS+vjxBjFxFwCzI/QhE6B3dtKkEpIoQjN8CtF7HpKG2M0ZLsdmW8S+HlD+DlQuNpG',
    'Mahakali':
        'BBXojnS05lxB0E3OvHvBtUhgB3N/EyGnkBlHzRzT5GUgN4FfkFgO7G4MD+U/G8HmEwKxImD2EsIjFyLqT6KP6NiOkU2W+KuF/C',
    'Malikarjun':
        'BBRkxlSomjxBqEzEjF/N3FgBSzKhEpJjFOzBvMrpBuLhC0dgRiE+C4f8GnI4VsgBmG9DlEvKgJlO',
    'Marma':
        'BBTw/lSw/qxBxLsClH9M8EzKoFmD7F3QmMlgB/UzGjb/lB5K0KmFgtB9OsjBiCoS8LmPmSgvBvIiWiMiIqNnLjCzV',
    'Naugad':
        'BBSgwnS+5nxBzJrXlM+B1W9KhOjUQ5NvTlK/I8E5J2WmL+lBtJ+E6WiiB2W0H6QnGsGkNqGA+SjQtDrQ',
    'Shailyashikhar':
        'BBTgllS8klxBzCzP1S/b7GoINvSvF2QtNqGhF+RpLnEkL0ZuKkJ+BulB7FoL6DqO4HkF0KxK2IkEoFlFlL9lB',
  },
  'Dhading': {
    'Benighat Rorang':
        'BBdst/Qi11zBRhRhIzN3FiR1K5E3CiX9H7D3EiIzMjH1E+C5FkLgJyoBvQsY5KvG5M4IkNqS5Owf0Q8NqOzTBnJkYhN2CpHgY4I+L1E1GnFkG9H3F1VmG3GnOlU',
    'Dhunibenshi':
        'BBNiu+Qy0g0BzFl+BxNwExC3HpJ7C5YF3IwSsHqY8VqFoHmP2F/EsFyhB4PzC',
    'Gajuri':
        'BBPii/Qkm7zByHLpMtQyG/KhEpZuEvSzdhI1CqHlZ0OkB2HlOoShH4hBgOiWwkB9fqLjC',
    'Galchhi':
        'BBWs+/Qo16zBlF5KpRiOiByOxKnByCjDvMzGpLkChC6GriBgZJ+FujBuCHoKiJuDkEqPxK2UgIsJiLzbwM9G7ElS2OyGyFxK',
    'Ganga Jamuna':
        'BBQ+gmRmu7zB3VlEJxRtO/G/B3P8M3O1C1PpgBpNuDwPjF0fjO5C9NqUyG4Voa2NgQ2RiW9C',
    'Jwalamukhi': 'BBJ2tiRgv4zBkB9M5L9bjhB9HvdyPwVq4B4V2DgW/G4J7N',
    'Khaniyabas': 'BBMmylRk+8zBlMvTrRBnNxQlYtKPkmBkXkW8GyhBuS4GoCpNoP9VnDxK',
    'Netrawati': 'BBNsujRgy7zBvI3c9FnChHkP1B5XvQkKxK0S8E0OpG0TyPwN6OYiD1QwSrJ',
    'Nilkhantha':
        'BBVs4iRyv5zBahU3JpL5JyS/VgH3V1DvI4PlL/EwDyJhO+Q6DqRpGisBuFI+E7K6QDkpByQ3C1NoGjO5EzLyKzSgQ1H',
    'Rubi Valley':
        'BBe6zpR2o+zBKtRvMlVrO1I7GqDtSpG/F5QlHvBkCrE9TtShOqH7QpHlKqR9S2L+O2StGsJoDyKnP+VpBuS4F2JkO4CwNkMqI8P4RgDgMxK6QuJoT3NyPhCoQ9KbjM',
    'Siddhalek':
        'BBQ86gRyj5zB3U5uBrb6EX4TjG+H6GgF1KqHiFoZ3Hwa8EqKgFsBa1Iod9VuE/HvDxJwMmE',
    'Thakre':
        'BBQ4y+Qkm9zBjChS9InDDzKljBnCpFoUgF8E3JyCyNmf9KuPsb8ElBsGuJwBuOlOmDrL/HrJ',
    'Tripurasundari':
        'BBO0nkR0l5zBlEzQ7QrH3UsBrDzN3SrMkHiNduOqLgLJ0mCiHjPyKqDgKhUkO6C',
  },
  'Dhankuta': {
    'Chaubise':
        'BBSq7uQo/s1BwGjH5KpP0D5JzK1MPpQhyBoGjLuZ0Jof/JmE4D2e7D+KsIN6IxJAtX2KgGsU5GsOuD',
    'Chhathar Jorpati':
        'BBQy8wQshr1BmN/E/NhVmM1eveuIpByTtHuN/S+BpVrGhQ6IwHiMG6P6I+GgWuBiF1GiUtC',
    'Dhankuta': 'BBM+owQs3p1B1KxXxG+H5d/WpiB2G4F8F3EqI+GoEiJ2rB6P9HqVsGgT9B',
    'Mahalaxmi': 'BBM6hzQumq1B3E35B3NsG7JjCrK5P3SsWtLk2B8M4OqOoBkIwHqTpU+HgB',
    'Pakhribas':
        'BBP20xQomo1BsGjFnGfnUphB7UjI9boM+C4P1OoKpEkUgY2WyG9H8K6R2GVwXvHgB9R',
    'Sahidbhumi':
        'BBP8xvQwzn1BjCxQrZ5XjNUlFjI9EmGhLJwH6ErLybiDsL4I6E1DicsftF2K2EjCpR',
    'Sangurigadhi':
        'BBVsvuQiir1B7MvelDja3G5D4E/HhG1E4E7e3I5EhDrLsL1b7cHjJggB0JgL/HoOyFqZ9M6QnFscyMmO8CgSmKpIwiBkB',
  },
  'Dhanusha': {
    'Aurahi': 'BBIsjqQ0iw0BazV5OiFtGzHzKkgB0JP2C6K0K8B',
    'Bateshwor': 'BBJu1tQ4wu0BmDxHuJ5BhD3HtgBnL/DwNhWJ3C2FiK0K',
    'Bideha':
        'BBQi6pQg2w0BtJjB1C5KzJQqE/FpL/FjC9M3GrD3B6NgIsLvFgZlJqM+DyG6doD8BnNkH2C',
    'Chhireshwornath':
        'BBPmxtQwyv0BzQxEShMpJvMnMxD1IvKxBsN7H1ChEoI2C6InJcnI1H8BwMykBqQqc0C',
    'Dhanauji': 'BBJovpQyov0BhN7G2E5KhF9F7EO5CyPtJ1CgMyf6MuH',
    'Dhanushadham':
        'BBVoyuQi3w0BtUzcrM0DtoBlI/FoR3N3F0GiHlF2E9HxC2M2Q5GiBsGuDhBgKtIiFmKgDkH5E6N+C6JrP8YrJ8OGmK2H',
    'Ganeshman Charnath':
        'BBWs3vQo0w0BKvOnR2DxRhEhN+HmMsHzHsKlMjI5jBoInLqQ1IS/GmJ2Gmd0fzO8OqBmL+LxcgrB0JgC0G8VoLrCofrqB6V92B',
    'Hansapur':
        'BBT6xrQwxw0BahEnI+CtMvIyC5MjGlDyM5BnE9GlVpFpJmDc2U5JiVwE8FmMpE8C8HgP2BmCvGuG2BgC3I',
    'Janak Nandini': 'BBJs7oQ6wy0BpCnYhN5L9I2f/NvBdiE2M8H4HxCqLqU',
    'Janakpurdham':
        'BBRwkrQi7t0BrUnQvT0IvOlE1QwUF0N0JwF1E6KoM8D+GwMsKnHqPS+H1PiIgBqC7GtH3C3DxQ',
    'Kamala':
        'BBP2uqQ08y0BqIlG9K9LhKrD9B4G5OGgD9K7Q5EIlL7L6C4D2azHgY+GoIscrCyWvL',
    'Laxminiya': 'BBN0jsQimu0BjBzE5X9E1U2G+D8PsHwBzBoGgITiLkLqFnCoB9QgIyCjCxK',
    'Mithila':
        'BBdi8xQogu0B3BpI7SyWtMnBvJwG1LpIhBzK1HwHjMtJrexDrBsHlShDkD0HvJ+B7C2Hxf8C+KkOhC0KkSgGvHiJqUhBwN4QkO3G6M+EoR1DiE1WkhB7Q0HlLsS3D',
    'Mithila Bihari':
        'BBQgjsQ6mw0BgG9QxgBjN/BxLtPvB5H8PsOBqK6IvNyDkGmDxC6M8O6IoCxG0HgDmF1EzGhH',
    'Mukhiyapatti Musaharmiya': 'BBH6noQ8ot0BvNtPzP0DjNtF4Z+wBmGpF5B9N',
    'Nagarain': 'BBIqkpQ07t0BtIhGpJoF9MzPxLmNTid0gBwLuD1d',
    'Sabaila':
        'BBV+ksQ2zy0BmCjP7GpHmIlN9WnBuIhFiB/JrGtD6GhBxEzEtOpC/B4ItG1BlCwGhOvCtE0QoZuL8BmHpG6FuD+IwWsF',
    'Shahidnagar':
        'BBUslrQyjy0BrB5I1Y3KyE1O9D/I9GbxBkHrJxIpDgWjH1C7BoNjKtDHmL8Q6EtCkLoOLwGhGuQ0OyMhFnD9L',
  },
  'Dolakha': {
    'Baitedhar': 'BBIw58Qyjy0BnLzStiBlMvX6jBgcsc8T+D4BlLiH3C',
    'Bhimeshwor':
        'BBOi89Q88v0BvFlVoEjK3UtP7Y4B9B6HpK6D0OuWjc6dpJuVmd0HoMuLiJ7V0S1L',
    'Bigu':
        'BBkBsylRmxz0B2V7EtBxH9QQ9KxWlQrHvF3HiEhQhE1FtSsH9ZzJzWkP1RmC7NgMjOrlBhb/OvX/YnN8KiG2XhN0MhJwf5dgXsPkUodgRguBtB2O6iBkIdsb2O+K/GpDjgB+E1G2ff2gBhNwGmCcoJ+J1B',
    'Gaurishankar':
        'BBpBy7hRmq20ByK1C3KpKkI3Lrb1OjIe1O5iB/tBuBnd/Q9R5WtSvLhGnMtL0LlDyMhH4C+GqzBwRmHmE0XwGsNyL8GMgN6U+EyCshB0JsGkDjHqO0F2K4O5C+Q5KmKgB4iB+8B4HiOpEoH5IpBnHsKhEvG7chKKnPlRS5TyTrSF7U',
    'Jiri':
        'BBZwt+Qi030B1Dhe5U9EL/MxL7GvGrNlEzXvRlHuBlPzJzYrUnE/E1JvN3G5LsI1HwNsLqK4S87B0tBsZ0G+Hf+OqNqO6D4P6KgC+FrKoNkC',
    'Kalinchowk':
        'BBNgq/Qq7w0BtF9YzO8DlI9D7J+I3K5DlKyPhSkLzImYuN2UgVmOwclVsKphB',
    'Melung': 'BBMin7Qohx0B5DlU/FgIxHvErIqD6FvQpMpZrJoMjV7H1E+hC+a5HqdkB',
    'Shailung':
        'BBQ6u8Q4yv0BE3H/NvPsMhGxDtSzQ9EpPlQ1OmqBpUgSqMqZ5FwQsIpDyHwEgG/HuE8Z4LlX',
    'Tamakoshi': 'BBIgq7Qulx0B//BsG1WuSyNsQucmKgNyRsTzVnI3Q',
  },
  'Dolpa': {
    'Chharka Tangsong':
        'BBiCkh7Ru09yB3WxnB9F1enG/E0J7enYlLjQmZtFVjChKjelE5KmHzZ7IrF9ZkHpkBgRe8OzHzW3RrMrUpV9CpT5MxRjW5NgDmCwOrNwkBxDifjhBxGzV0GtX3NxJgoB6GkMhN4dgKuerC4WiSyQvB2N8N0tBsiB9BmFuNuTtBoqBglBiHsNmRwHjC4K2EyDkevB8OsEoDuHiKPoK1J8FyItBkNuMuGT0M+P7C8EhIyI2ByDjFhL/O+NvOhEvM4D5IiO5CApU4IlKvJlQkPlH',
    'Dolpo Buddha':
        'BBgC4whSwq6yBxG9XvlBnmB/J3XrKuRvXsJliBmtBlQgI5NlYwEjNtN/B9NvL1WuG1GrG3GpW6I/ctOsEtG9JjmBsLjfnlBxP+N7E6SvP2UyOoO7O0H/QdjHqkBsF+ZwWqIqMtGsT+BwMkCgCgKuFWkQlZoYmLzJ8eoGgF+F2egXqmBpHkfjPoHwJkQuY/E0FvOyJ3CvD3NsV5Q2TmE4L1SqNhC2C6GkLmCwLtH6E5auNnD8J7OkSqB6I9RrGhVuFjJ6exHtB0LmFoG',
    'Jagadulla':
        'BBsB8s+RisvyB6LnG7JrG/QpciInLwQNnItoBtTvGpJwMtRmE3G4J5OG/JjVpNhD5JlN7D6FvE5DnPoHvN6W1GpC3O/nB0Era1DhQ1L1H1hB4xB+E+GdqZrPiV8H6N7QyawbuByEmT0N2F0HshBwhBqGsVpPwHgbwV7I8KkOkO/D+P7Q6XqLyE3OqMtL',
    'Kaike':
        'BBhB6q4Rgg2yBjIhMlQQlIhGlS2DvC5ZqG7LpFnEtT0CtB1HzX1IrEBSiJ3W7DpcyGnNnH/U4WsB4L9OssB8D6GzauVqCmUuX4N0VzGkhByG8Q51CyO0C2OoUkUqNwUuCiU+X8P3U8E5S',
    'Mudkechula':
        'BBUgk5R2/pyBxD5Jv2BxG7RnInJkElIqkB0PyRHyY9UorBjDoY2RnLuKiB6T8d8Qxa7H5NsPhVepZ9E9GoRtTjBxI',
    'Shey Phoksundo':
        'BBsCqmkS6uzyBvN9iBqD/UvZB9KtUhtByP/E/JlXvNlEjf1RlFjIiHzdvU/awxBzXrLjLsN5QqHlN7NvV8IvH/arVqPnoB5EvNgI9BuQtT2L9F2sB3N6H8Hkb+KoB+PuMsFqS1GqYqf4e0EqLqmBlLuG+JuOrE5Igd4GqW2GsG2WtG+NwLuNgCvEkN0NkYsQ9HmiBltBwXrJmKvRmK6XwlBomB4G2XiFhEEnSkH9KkKoCyDpNrLvKmChNmM4D+ErJ3DzL2G/GxHrC3CtQ5F5CwElKiKtCgD5N0OlGnC5H2N3H/EhFrB3bsHvJmLuEsI5H',
    'Thulibheri':
        'BBlBgu4Rsg1yBzFvRzajNnH3alSDpYpS6DpS6N/UzPta9EtF5KmGvUxHjMhbwBpJ9H7FvDyFrM3BhLuc9WyO6J+JnCgL2GkLtBkxC8IrCoI2GqcxG4W8DRhJsEC0X2IuB2HuTzCqFoEtG2NgFoZ6P9E6b6H',
    'Tripurasundari':
        'BBZ4h5RuswyBlGphBzN1FlE3S1c5B/S9d3KdtNwMvCnMzJgQKiQ5c2M3M8N6M6e+U8H6KlGqI8JoMgW5NgV5DqSmd6ToZrHkH7uB0T9L4BlQ',
  },
  'Doti': {
    'Aadarsha':
        'BBXix+R41rxBpFnR/GgFrM7F8CzJnK7MEhZ5E1GpN8d3JtFjIwFyIoUtXkXkKkVEySqKkL6IK1CtRiIjDiI2J4JxRiIqBwFvN',
    'Badi Kedar':
        'BBhBs84R4xrxBJpLpRhYrH+FnMlClO3PmGzIjJrI8DjVlWExFuQ5IA5GsWpcoLmDyJ0Z2OlHiR5NhB/FqIkF8BpH2I6HuK3C0fgSiH2KnHoX+M8LrFoOkIiJ7f5BzT+M9FgGnPiIJ',
    'Bogatan':
        'BBc6v5RqlvxBlFrYxUnO+J1kB7H9gB7IoBjGsP9M+F6B0ThJ8fnOjI7LsFnX9M1KoH/RhHqLsP1C+K+P4RhJugB2I0C+ByQ4PuLqStD4SvO+JwEoC1LmIPuXtb',
    'Dipayal Silgadhi':
        'BBb098R08txBHzL9MuI9NpRgHhJjBnTjKjVqP3RvN9CkCwI7L6FLwKnUqM4E6KjCmDlC7E5HwL6I8L3kBgsBsVpC8c8Q+DzXqMwEmElHsKSAtHoL2B',
    'Jorayal':
        'BBagl6R2noxB1IjkB6BrQ5GpN7NtE3C3PrPMnIhZ5J+ClagpB0G0M5U+TtLgtB6E8LuVS3F2R0IgGzF4LiG6I8TkJ8H9FsSihB2M5C+GrISxcyRvX',
    'K.I. Singh':
        'BBPui7R6ntxBjIhM4HtLpH+G/JzJ1YvE3YpTlHoD8H+gB9J2kByUoOqFgWoQxFZtO8EO',
    'Purbichouki':
        'BBTui9R6hvxB1HlfnK5BhB0HrKRlEmHrNxD7C2W7c7Q1MqB8BwWqPwcuIiD+G1K2IuB4X+MuDsJsLzeuL/H',
    'Sayal':
        'BBag0+Ry0sxBwP5K/R1UjRkMvFwNhIpB3JyRhI1JhIkD2CuR5IJ1IxKlFiEtCkFkIiGQmI8FiDsNhHlEyb4IoQiU3OkF8NiT2BkFpV1K1SlE7b',
    'Shikhar':
        'BBhB6n9RgypxBsInFvTpCvK4KxItCsEjKrG5N7OgGxEkI/NhLzIlUjYrBzCkoBnVglBmD6OrVoRojB+WkSmBoK2JsHhHkC+EyCvHrFxGoUpMMvK8L5F1CpI6Q0DsFnGxInUkIvF4JuFiKhQ',
  },
  'Gorkha': {
    'Aarughat':
        'BBSw4mRim7zB7RrbOvPzJjIwDjS9HhnBrbYvI5PpalGnG4pBqwBqVsC0P5MsOkCiQqO2GCsRoSM0UuJ',
    'Ajirkot':
        'BBQ08pRko2zB3K5R/L5G3SxH7RmD1VzLxQuE5bjUhF6UzT2CvGkN+TmS06BqZmOf8JvIozB2I',
    'Bhimsen':
        'BBT6hkRw/1zBD9PtGzGjGsLC8TlKwCVpFlU1EtNkY1RuJkM+D+G+R0Q0JkDoNma5Cf7eyF5JtEyBxB/F',
    'Chumanubri':
        'BB5ByxxRgwzzBtEjiBjQ5MnMgM3C8L/MzEvGgGjHjCrP+OrtBgD5CuHhZ+GtOzDlGuLzP2J5HiY1nB4YzNqUmEqX2J8FjGgIxF+/BlRuXkLuE4KqjBoW+YwH3I2jBSlI++B+R8LkDwV+ZoIsBgN4V8C4RlL4EyJyN2FiLvKd/Osbta7JrT+F7SlqBxoBlIwCxFvG3G9UmJvCftbjOtbqY3vB0EtbmMna2VqG2H7WkavPiH3KbjiB',
    'Dharche':
        'BBiBgjsR4n8zB/kBjEvH4InW9Y3KpjBjLrEmRvXyF9/BkG/H3DrElnBSviBqO9ZanK+JlYoGAorB0JkINwP6RqanGoP4O/G+TuSjCsEmHwBgG6QuSqG8GpDsO2IwMmVOkRmc2L4K3GuVdmM3N',
    'Gandaki': 'BBMgvhR662zBpGtKpBpW9czavMoRrT4ErOonBmO8T/FyGqD6FitB3U6DnI',
    'Gorkha':
        'BBR06jRmq1zB5N/kBhtBpf6BzZ5NtQ7H2UzElDoB+W/HyEyX+HiJoM/EwtB0VB8I4NxCqIwX+K0FnD',
    'Palungtar':
        'BBQ8zkRm/xzBhRmF9GhNxdzFhLrSnKzFlL2EnBsQjI+MgMkNmDsbhEiBsGoJ6kByTmQxO4QhF',
    'Shahid Lakhan':
        'BBUs4iR+91zBoC3F7I3NzVCyF/qBzJ3O/LNvQ1KlNI3DqHnEjDjC4N0MqNlF8KwFgJ3GuG+c0a4HgmB8HmC2RtJ',
    'Siranchowk':
        'BBOo9lR8x0zBpTniBvPtJrH1SlIoc9P4DvPwO1H7DoO6N2Iwc4OoHiYkEgFvM0T1C',
    'Sulikot':
        'BBVy9pRgp3zB+FhB5FrBhBrJhN4C9oBvJ7JwIrUZt0BvX1WrUvgBpIoGwS9KyoB6c2F4I+PsbXuE+NmYnGoK9J+ZZwiBpO',
  },
  'Gulmi': {
    'Chandrakot':
        'BBTsimRy38yB9C1iB1DoI9W2F3IxSnXwMxI2LzC8K2N8JmKhE4GkR3JyVoHoKrIkLgD+L8N7DkI/RiHwClDniB',
    'Chhatrakot':
        'BBQk7jRsr8yBapNhHpH1S8DO1J/J3KjQ3B9QpQ1J1BtCwiB+T0L8CsO5F0LqpB/N0CmT8I0E',
    'Dhurkot':
        'BBTqqmR0n3yBhGxG7f8P5E/hBnInBH+S5KoCwEuOtJB/F2PsRuUpJkLmRaQ6F8NxFpCrLuMxEjFvK2S1J',
    'Gulmi Durbar':
        'BBT00kR6z7yB4P1EnUhJzB5PtKtE7MwFhCnHnLA5G1G/HgDzEpF3OkLC4R8QoCgK4KN2J2S7DiHqHf+J',
    'Isma':
        'BBT0tnRgi5yBlFhJnP+C1a9JwCpR7E9BlOuIiF0KrMuEwCmL5N8H5D0JsM8BtI8I6GgIuIP+vBhOgItHG5Q',
    'Kali Gandaki':
        'BBQ8qlRqi/yB7GnLzTiK7HrR7JAha6mB3JvFrN0JvBoR2UqRyQ5QkBxK8RLoIsMwJpLuPtF',
    'Madane':
        'BBS+znR8k2yBlFnU3TwJ3R3E7D+H5GpD5HwM7CzEzIgGvJhFqBktBmUlL2FgEqH1HiG+CN6M4NzQ0LmK',
    'Malika':
        'BBQo9nR2r4yBgIxH9MtP4E/DPnTvO7JhHoU7SpG5W+cmBwT2a+JoP9CmF0IuMBIjQ6KmF',
    'Musikot':
        'BBUshoRy54yBhHlIb2QzWnDF6Q/HuHn2ByM3IiOkLyHIiTxLqI+G4NsZnF2DnI8Cqe+R1NsDjGtFzPuFrNrGrU',
    'Resunga':
        'BBWqnlRoo7yBTnPhLnHyIxL1InJ0ItHzMvCoIlMlFvF7SDvNsRjRqC5V0MwH4K0KtCwEoGoLAiCoH8MvF2KyE2C6QwS+H',
    'Ruru':
        'BBPuojRgy9yB6IzN7IzEzClTpKFtE6H5K9BzNkJ9E1C3IwKyFgL5CmIoX4U+I9IyG4B',
    'Satyawoti':
        'BBQ0zkRix9yB0E5GtG5QvK4D1N7JhWooBvXsL0E4LnLsW0EoP4QnH4JwFia5mB4RiDsF3InHhK',
  },
  'Humla': {
    'Adanchuli':
        'BBP+zlSmy9xB7B/MzatB34BkpB7NpGVwPseyX1C8Q2IiIlCsIkYxLM3KoIxJrB5KqUjK',
    'Chankheli':
        'BB5BgtrSgrmyBvGxIIhlBxYigBnQkJvH3BpL5QtL9BhavyCtMmEpLjGqCrZ9TiJ1K3HrE5OrNzHrIgLpN3MrKuZN6QjLSxSiUzU2E9HiIpL5G0OshBlD4WgGia0XzBuB0SxG6MuMuToCyQ/LmhB+KwLmLgCoSvKqKyJoRtH4FgX8M7EgQmD8CoRyOrJsG0M+M6BoOuQqOtOoFsByJvb8V7WyBnMxJmBNnJ4WhSzFnWyO3K',
    'Kharpunath':
        'BB0Bw4wSszjyBAhFtsBxRpRlQjUZ9KrP1egRxbqC5JpJ3lBvJ7iB1bxN3YwCzfvDzQvGhE2JnZ7VlIrHnK7FgMviBtE/LyK8B4KrM0Z0ImdiL2LkS9G2VoZzG0FoBoRpMqOvDoesLmGuMlE+ZqyCgMuCoL6QsXzHsf1jB4V2M8G5J+IwRgLmEsE1O2SyBdjQgGnM0QlHKrLoI7GqMqMuLtF0P6L',
    'Namkha':
        'BBwC00ySso6xBAnFtNwCzHtJ+J3c7MZ/CtFxUUmH9mB0V5boDjXxPxE/H8R/H3FzBvPnJ2GzS/FtL6QvHrNlHtBC0K7MjFxGnK/Z4CpTzcxPxLXxJ2HtHhLtenVuV7XTlS/K1Vm1BjCyP4JkM/Q0mB9TwDjJ7JxRkGrM9DhH+I8B6UmHiIwLCyQuqD8HlBMwJ6a+M2DwYuK/G+FuFkM3D0IpLwD0TnP2JlItB5GmP5N2L2EsO8S+RiRqH2BkSmK+HuPjDsN5NgoB/GkK9HsJ4LgH1F0TcuJpJgX8JwO3O+M6IoGrO1CpSyHvKelkB+FjMkIhD',
    'Sarkegad':
        'BBdijoSi8gyB3VlbjS+GhL1LzIldsMzZ7B3KgMxKvEhH1ZvEjK+G1P4uBpUkKsB6KnIyJL4KjYyL6SweqOqIqMiRsKtZqN4MsI/KsN0HsE6O2K4H4U9J0MrShB5R',
    'Simkot':
        'BB6Bm/wSqp/xBoBtHvI9EpQiPlVlKtJqJzTb/G2FrJ3LjK+H/nBgHrN6NtPkDlK9H1BjShRpH7S9R1ErO6N1L6GlPmIuBoP1JxD3TxIuLjM4D9FtFtKgH1DvY5a9M3DlKrd6TgBgoBsHoKqWoJjKmYwGiEwD0QpD2bgF2OmsB0pB6lByJsH0IgezB2e/QgLsPiUaqRmQusByR+FhHtBjLlPnHiHrZlJ/BnF1O6M9T+FuDkFhIlHnH',
    'Tanjakot':
        'BBNggmSgj9xB7D5TpkB7HzhBxS/XqBpWuYHiWuNmKnE6X8NqGs2BroBwXjB6JoI',
  },
  'Ilam': {
    'Chulachuli':
        'BBZg0sQo8v1BiEvBnDhdxd2mBrKtDtKwO/MhKnF4H2CqJ9lBwKlTmkBWiQ6IyBuIwPkJjJuWhGP1SnJ3JsFzWiK3CqChJyP2FkEhMwIvEgPiI',
    'Deumai':
        'BBYwnwQo2z1BxR/kBnW0UxLJtF3KpZjU/NqJtcnI5K+EAkLvHC2GgMnFiSgD2MgPW+IxHqMwKsWhB4CoMvFkP2WnF2FhQqPpQ8MqF',
    'Fakfokathum':
        'BBN43vQy6x1BxcnkBlOjIlOmSnE1HxHkCkKooB3H0DqZkUuF4K+XjG8JlO5CnM',
    'Ilam':
        'BBiB6xwQ69z1BrIjJ9byL7MpFpPqQ1FiQ5VqF0ElPrDtM3VoBpMvK9IyH/OV7EgNqMqO8RgF5DoCkC6JkFvB7D4IqHsJlJ2WwH2I8MnGyCrHvFjY6oBvCgMkMmKS0L5V3LEZzLqS3MkLc',
    'Mai':
        'BBbq2sQkl11BzY9LvFxJkH3rB1G/LwHBUxH3LrR3E2HhP1GxImPxpByRnPyW3BmOwMP1E0HiIkctFgG+SvDgG4NsN0E0KxGUmG+OwDoT/GgD3G2LqK',
    'Mai Jogmai': 'BBLmhwQ8n41BjFlbzKhF/F9jBjRZ/LjM5oBwC6UshCmfduD0KiO6L',
    'Mangsebung':
        'BBV27tQ2ky1BlH3nB7T7HxIpazZ0a/OhIvIwEjEiM3PxFjC+IhK4CrFuWoJ+JwByPsM7EyIlPiP2G4E1H+J2PwO9G+ZsI',
    'Rong':
        'BBgBstsQgl31BoJ7IxPqCrfxc9HbS8JhQsBY4JwQ2EhImCgH6LpHBnNyM8c4MlFmGsLwJ5Y4C9JoJmUsM7HgDsC0F4WqD9N2JF6LiV3DiJzMsHB9DrG2ExP1M1F4EtRsJlF',
    'Sandakpur':
        'BBTssxQ2711BxHhlB/S/VvO4LpC8JjLbpS4Ma0L4LDzMwW+HNkGqkBwK2EjB6H0FyCqK7NoOjH2IiDwIrI',
    'Suryodaya':
        'BBf6tvQyx41B7QnNtDzKlfepPnpB5CyHzN8FvGvImJvWpHxJ0DlJtOiQ7LnK/C4GzVgHugB6d2PhCvJ6IhCyjBrJmF1E4Q0MsG1EyP+DsGrHCrD2I6aF0SrW+NgGsS/PyVuJ',
  },
  'Jajarkot': {
    'Barekot':
        'BBeo54RwjnyBLnM1EoDnErExBnX3GhBhDnO3JxBlHlL2ElInNpM3JV9PnSzV0azU+I1KuTxRuGzBiKhG4BnH4jB/P0C+B8WyN6B8LuPyGgakQIiV/I01C+OkNjlBhEhT',
    'Bheri':
        'BBaujyRw2lyBiRrIxBpExVjKnF/MnLvD5G9b3RpRnXlEzSwKxE3LzHmJmFmkBxGqB1C6PwK6NqiBqExEwH6W+XzLkU0HpCoFoFmDjI0KnB+Mjf2NB',
    'Chhedagad':
        'BBiBq9zRyziyBjF5TveoD3S/GyGtZ5DlUvDvErFkE0C7SpL5RnJnChWggBtF0vBvOpDjVqWhFnBmE4MjGnB7CyIyE4L0SvKiXiE+RuR6G+b2N6GwC5IkT1DzE5UtIzI8N1I2B3JkGmJoLnM4TyB',
    'Junichande':
        'BBXs42RgkiyB4HrNpJpE5Sta/EjY/gBgDhPjTpgB1JvX6GlWkSDkP+HhC4E0WtG0Z0S6GwenDqF0U6TgO8JkE2V1I+IkFsHnS+N/C',
    'Kuse':
        'BBXyp2RmhkyBlOpcvKhH7V2IldhSzZiCrLqMjGlJ1B4J7N2IuI0I0E6UjT2DnC4P8NqE8MgNqUyBqZ4UiG1B0BhKyRtGmM5UkTxH',
    'Nalagad':
        'BBjBo32R6nryBzQ3XmI7kB1gB7GnE8F/b+CxG/Z7LtP3MG3C7YgQzCoH5jBphBxW3TKlL4M1NClJ6brOyElDkIwauDsD/DoO6GqEynBof2a8FiT6NuPnD6J6GsQ8JqGwQ9B6FqHiM3B0XmY2B0RiN9b',
    'Shivalaya': 'BBKkuxRwo/xBnD7crKlKlTsYhfiQ1EqnB2Dk6B0X9XwOqDuFzvB',
  },
  'Jhapa': {
    'Arjundhara':
        'BBa2/qQih21BgIazN3ETlGzKyGvN1EnBlJ5IxF7asMpKpEzH0DwBiMqG8CjCymB8QqH8QlD2F/bkOoP+P+HuKxBzGjMiInCvQzEX7F4D1FqMO',
    'Barhadashi':
        'BBU00nQw001BlSgHplBlBrG2IpW/E3F2J1INI2PgHxEkNmKqMIgI4JS/L6JtBd/IoMamImS6GnG0IoD0NxZ',
    'Bhadrapur':
        'BBWs7nQol41B5I9F3D7LjGyD3F5Ghc+JlNrFtQ+IHtGxR7L8D6PvO0CrDwR4F8EoM5CyHyJkTpFgBlFmH+H6L/C0EoIkanI',
    'Birtamod':
        'BBQkzoQm421BpGzbtX9JlL0M5KrCxDwG1HfgE6S0OiBdmQ9H8K6K2FwJBoMhK0QMhB9R',
    'Buddhashanti':
        'BBT2rrQs041B4C1D7KxIoFjG9c5M0LlLlSzH3N/OzF8bjLwBZ6Z4XHgB6IjckNwT8EsG1FhCkEsFaqW/P',
    'Damak': 'BBLykqQu7w1BmK/GrMxF/IxOxmBtI7X2ItQnKmIqS0TiJgQwRuK4D',
    'Gauradaha':
        'BBYgioQwpx1BN7FjW3IclKlG7EkHhLnIvM3TsGhahCvX6KJ2MkR2D3MyK0FmJJuXvE0E3C9D+JoWyLxHuQgBsGlHCxTmJoEoSxQ',
    'Gauriganj':
        'BBawkmQ64y1BjFhK/O8BtC4F5FvHpGnP4C+DuErEcnUjGzM4MxKjR1DwC5JnInEvGuJtIwBxFuWnJqHX2byG2F8RvB8K6H3D2PiR8L+G9EqOmD',
    'Haldibari':
        'BBW6mnQq221B1OlB/D3SoEjClHnPhNbegJ5JuBNgMjI3JnTtFxByLpL8HoIoMhEyByEsV2NoJDsG6Q7ImNsF4WlGmIvN',
    'Jhapa':
        'BBYyqnQ8n01B5O7CvBjOhLTrI/IjUnElH8E5Q5LpHsLnGbpC4M4HgImJhCiIkRsG0BvMuPwHtEyRgG6JrJ0EyEmMtFiR4CE3LmGB',
    'Kachanakawal':
        'BBZ6+kQ+311B1G5F7F6EH1P6L1DpL9KpB6PnJhF3IiH5PooBpOQpFgJsCwO+Q2CgKmXsQ4KmDpR4O/ClF9EoB1KmEiD7E5VkEjBpI1MqL7H',
    'Kamal':
        'BBX+rpQylx1B2BzD7MgFvLpE9O9QzThJlJ/R4DmKjHgLmG8EbmKkW4IWuFzYZrS0QhJpEJmU1PuKsSsC2WrQghBuCmSyNVhQ',
    'Kankai':
        'BBQ+tpQ0o11BhIlc/F6CrhB5Q9JTlCyI5GN1B0IpHmBY8H2TnDhG+d6LyGmLyDkKpKuKqE',
    'Mechinagar':
        'BBc0xrQk351B3WvErCzF8H/ClUrMhWwHvT7E8b3MSnGjM5F9MkDc9Y3RhBnDrF9YkEhHwL0JsIvCoF7iB+T2JqCY0KoRFqPyH4GyLsnBkEqYiM+bfG5L',
    'Shivasatakshi':
        'BBRurpQ2kz1BlI9N9QjEnJzKjiB5C/TuP7NPhEiYkSgMkHpBsDkPqUY0C9I4JUmiB+QkK5J7MrB',
  },
  'Jumla': {
    'Chandannath': 'BBLmt9RsqkyB8CzJ5PqClElMjWhNrSkL/I6RpC9ExD0DIiiB0fkS',
    'Guthichaur':
        'BBe++7RwqmyB0IpOziB1UjR8V1OoC3FmLlNB3E+RjHjC7Q8JsC8JhGyNiEqSjNklBuZqD6B4KyLwHyEyiCuE2LkL0GgO3W8Y/IxGtI2B5fnHrMqD9OxFxakK9QiVnOhI1d',
    'Hima':
        'BBOuh9R4rgyBnL1T1exR9FnU3L8B3L4LtHsU5H6F2kB8pByL4mBuNtMJnV0RhD7CrG',
    'Kanaka Sundari':
        'BBVg7/RoxiyBxNrWkHjFA7Q9QnJlChSperD6GySjTsV7JshBgRyQoBgP5bumBwBkLgb5GoR6DiI9RmTpB0GhIrHzQ6OzL',
    'Patarasi':
        'BBlBsqgSs/nyBzIzRxJyD3W5HlC3hBvG/KvNnFJhTmG5GnR5DrWoIrH/JxdyhBqDsDzUgmBiI2dhZsS5G0ToG4TpD+OoHsM1B+f4F2BiGgR0Q0FgKkV6OF4G3JuRlEqJvMuTwG2Frc0tBzKrf5nB+EnNufxP9GlO',
    'Sinja':
        'BBT+p+R44gyB5GxSpZhDtIsDrB6PhJoJ8CsGzRiDKoVtNuMmD4V6duWmEmMmU/EyKxOhBtP/QxQWhGmJpb',
    'Tatopani':
        'BBoBo+7RwujyB2H1E1HrJgBjOxJzLpT1F7UuD9HgUrN6Btc3c3hB/DxaJ/KqRnTmGrHoS4P8buM1CqLwR4JWoNqM1EmImHmL4JyBa4L2J0FcmVoEsE2EnD4DyI6QjD4E9R8NHiF7K2OnCsJ9J4H9LHhiByDzDqC+EgJ5R',
    'Tila': 'BBOo67Rw/hyB3KxbjZ7frd9T3J0F7EoZzMsCxV4pByTsCuc4csN5B+H/T+VpD8V8H',
  },
  'Kailali': {
    'Bardagoriya':
        'BBPktxRulvxBsLtClN1RvYtB9EuE7FtP9be7PpH0F4Q3GmCsF8EpB+OyJ7CuYkPwSqB',
    'Bhajani':
        'BBe+zuRu8sxBpHjXpM5F3EwHrIjK9H2JrNqDxXvFpM8HsGXrGiK4GwHjGtG7BiMhFE6EyRzGrJtG8IkFX6F8XkO8S8JzD8JoE4InJ1C9I4QoI7Erb0b0DgE5F4B+D',
    'Chure':
        'BBnB6z3R2xlxB4D/CjL9J3WjGjGvK9aoHeyJ5GY/C6HqGiRzFiDqDwKvItB3P8oBvW4C/H3FvByHjLnC/eiS8DkI7JwX0ToMc4H5J8EoJsPgsBiZqIjFkIoHoP9C0EjNtJvMsIjHkRtBsKla2IIyKj9BsHnPiRlO9GrL',
    'Dhangadhi':
        'BByB2gyRgsmxB0FlBzMtSQ3XpI+DoBuHjKtLnJiNhH/G6C/FnMwCtK6dvLrGrD8KjF7E8CqKjIqDuC2S5FkGgFmKtNwHhKrBRuLlKrD/LoPwCgXgF8C0LhRmIrFmJ0D+D7FoOgFsMvF9CgV0G+C2Y5JTnEsH4BK3FqP4BuMnOrNlOmK/H5JmBrEtMtLoEvC7MqY5B4C8GgI5H',
    'Gauriganga':
        'BBrBo3zR+0nxBjHtPpfhIwCiHjH+GpLrI1DkKjLhCkCyI6JlBlKgIoNwMhC4HnKmI7JrD9FwH5T6E3DgQ0IqCvIgZ3Q8G9J7JnKsfwNsF2N1EyI2DqCxF8N+OwNRG8L0pBvHoK5P7Q5B7SrU2KvRoSgFlFlG8J9EpDrLnRxI8JvX7DjI2SpN',
    'Ghodaghodi':
        'BBZslzR8gtxBhHzmBj0BsGF7LvNS7N9OpCyFxI1DzQwEvStHrF1N7IkM1EvITy1B2JiKhL0RLwQ0OxDkSsM+bd8FuP4YvGmNgDuNpJ6PqK',
    'Godawari':
        'BBiB+q2R+0kxBW1V3M+BjYzM9KyahpB9IvOiHL2GtKxE3WoYvI/GP4X0MuSlJ8B2HyP9HuHpC3G9QlC3H8DwC8MqLpE8MmGqEpKqLsIkH9GvChHqfiI4Q6Q0W3C4P7oBwIuBlBnmBgHdV3J',
    'Janaki':
        'BBRs7uRgizxB3PzwBmL9ezB5U/FjC7EnR3KI/LtItBkEnP/LuCklBkEiFiDjI4JwEd2cpSkMwiBmpB',
    'Joshipur':
        'BBSqgvRm8txBlSjD5C+DvB/F/D6FzbzDuF8ZtCmD7O9JQ0OohB0P+JDwErGmP8BmDlM5FpI4GlC7FpO',
    'Kailari':
        'BBiBu1wRm1pxBhIpFGhNtO2B8ClVrMwFtJ5E3I2FtJxDxTsW1F9DpDuL7Je9DwM9LLpCyQ1PiS3DoNkJvCwD+InHyToVgB0KhLsIkK4EvHkMqFsB7pByE6I8IjMsF2N+HoCoKrf6J8J8M1B',
    'Lamki Chuha':
        'BBO4kxR2ixxBxLhLwJtQ3NxU5TjBtYjPlf+D6NsmBxLolBsSg3B0T4LwIrT5BrO8L/F',
    'Mohanyal':
        'BBlCu51R0trxBkFjInNvKhHahEyMtO0CjInHlIkFjsBhZhIrLnRCvHoP2S4T8Q6BnK6PuOmE5D8GqH6f5OiW7F4X5PpKtNqJhP5B4ToUtjBwP0NuUvJuQyLiLtgBoqB7LgG6BsOxIuTsc9DgGpJ6N+DqCtK+JkDuJ1I2LK2JzN6JkK2DzHuJqB0LjQwHBZtExRrC7EmHpFhCsLpS7ClN4I+C+R9I7E9IvI9BpE3OqLnIoBlKuHLC/M2fvb0IhYvDpJwEpSvHrIqH1IjF7BgGpI6NiB',
    'Tikapur':
        'BBZu1tRuiwxBxCxGzCkE3D3DjCkIhFhFnF/jBlb4CjMlOmD3ChOhEhE+DoEuGzG0CxHzK1K4JkJyB5LqU2J7E4RuQ0L+C6CwLyZqgBuMyE+SvM',
  },
  'Kalikot': {
    'Kalika': 'BBJq64R805xBlB3GrQrKnavCzMifoI4KjE6MiG2YmkBa',
    'Khandachakra':
        'BBTqn6R016xBmK/MhGvHtVzChNrSlSJwF4I3O8rCqE2Q4OsPkR7P4Q6CxGzQ4DzF0KgB4BjGjQhZiBtJuKkG',
    'Mahawai':
        'BBc8v4R2nhyBIvGvdQjEtJ2KjOmB3N+IjBzGzV8GzZiJ9EkD/WnGpTqIzLxB3flkBZxS6PjGkW0FwMxD6OnFlB5MmQ3HoSToP2JiXzFqH+EmXubqhBinBuD',
    'Naraharinath':
        'BBP8x8Rmn4xBJ5I7VhP5E7JrGwOnOoFrIlI5gBQnNsHUgQ9J0G1G8SmUuP6LpGupB1C',
    'Pachal Jharana':
        'BBSyi9Ru08xBxOlvBpcoB7F3E5KuKvVxjBzJgT9KhGb4K+P4X/BoGrKjBnDqJsXmzBsRvK2BjM0U+BmJ3Q',
    'Palata':
        'BBT8s/Rkz+xBtEpapoBxKgC5M5RnM1rBd3EqNhZwB1BkM3P4KqOie4PlFiE2T2eyR6GqOsgB1DihBiE2D5c2KhL',
    'Raskot': 'BBN018Rk36xB+H7EvK1PxG8E7FlFnCmLlV1UvHqK7TiKmTif6KtK8F4EybR',
    'Sanni Tribeni':
        'BBU0y9R0o6xBzBhczKnJoGrFraxV1sBqgB3pB6C5LqGoFmM8KwF6KzC8IoM8ThKwHpKmV2UkDpLgFqFyG7EyQ8QyHF',
    'Tilagupha':
        'BBX6i7Rs6+xBrgB9mC3Q5CjR8P3OrPlIoKkG2UjDgXhJ+E7G0Z0G0V9IkBlB4NhJuJwCkO+hBDmJlQ0MrC8EnZ4JzFwJuIiLMwMhZ',
  },
  'Kanchanpur': {
    'Bedkot': 'BBM+w3RotgxBpH9SuE9K5EtQoHnEpK3I/RwFna/JrlBubgVqqBidqOooB0E',
    'Beldandi': 'BBHoxyRml/wB/LvM/PgErI4qB6PS7C2MsIR',
    'Belouri':
        'BBU49xRkwgxBnBnIjP0BwE1S/N1GlMsNpG6Y9UsFnXscqFsiBkHekejT8LoHwF7G2N0BF1OmKvM/MoExF7K2HjT',
    'Bhimdatta':
        'BBbw84R2k+wBkGhC7WhZzYnJrBgFzctHlCqHtRvL2BjGtnB1CqB0c8XYlL6M8CgG7EwGzIVzC+KvOgGpC0G4O+I0f9ZkagK6RxFwK6IIvGsGJsM1P',
    'Krishnapur':
        'BBfgg3R6wjxBuE3BjHtH1tCvfvH4BlCzF/PsHtC3GrQawK4YzEyXxIyGlXnWxYrE/X2kCiHgH+JpN2J2LqB7J6IhD+E2IgXrYuKyEM1GgO/G+oBiJuL3awc0N4I1Cb1IgNiE',
    'Laljhadi':
        'BBXorzRwgjxBlC3T7WjRuH3DlDpM3QhIxIgChKyH6FsCnKkMG2O1NzB1IyJ8BqGzLGpSqpBqLW0EsLkV8BoP/tByYsEmXoW0I1G',
    'Mahakali': 'BBJ60zRmx8wB4LpE6gC8GkDjF3rBhatxB8DjIuGkCkUkE7E',
    'Punarbas':
        'BBVygxR+xkxBnU7DzErLpLVqSppB2LNiB7IvLlHpemTjHd/JsV7X6EmBiI/U+W6MiI+C1Fm3BpL8P2WC+IyDlHyM5B',
    'Shuklaphanta':
        'BBZmo3RmkixBBnIlFuEjehR7RmBlHvN5LyBpJ1N9RnCjWiK9E6K1FtDxOgHoE6KtH4D2K4DkEmIwS1CuC4GgQrHmC0FwH3BwuBoRqmB2V9GtY',
  },
  'Kapilvastu': {
    'Banganga':
        'BBYk0+Q492yB3Z3QldoKzN7DiF4YzTzMzG8M3FnCQwP9OlCrIqKuD2E9HoFiGwGzHuP2CyKuNyH0W9G8euFmoBzKpDxQqJ3kBtErD0EvN',
    'Bijayanagar':
        'BBZgs+Q+9vyB+C5ClKhGfhQ5T2H1NxBzJ4H9NhE3NqP9Ub1NkNxP9EzFwO+FwP/HkQwVBkN0H4GhF6M6CD1FoMjCmK7Q0drJmHzH2RN',
    'Buddhabhumi':
        'BBoB+k/Qqt1yB+G+BrRvO7Ch2BtOrDxNcnI2HrJ9E3BkGlLyD/H1GrYxBtJmO3L1C/C5N/FehGgFgBiKkKgFrDiJkGqCxB4F/K+D9E9DpDkMjPetB0M4OyFmBqLoN+S6KqDuDrF4OXcsO4XwTlErZ0N8DmdnKqQqG1G3P',
    'Kapilvastu':
        'BBbi97Qqi3yB+D5C7FzU3OYtDsFrL3D7N5dzOnFqB9MzExDhP2E1DiO/K9DpGiJuDwHqPuC5GsKkK6N5C2H7FlCf4H8T4R6P/I0WgR4UhBPvP4FoC',
    'Krishnanagar':
        'BBNmv6QyuyyByB7alOtCwI5N9FvPkFzQvJpE/OsH/C9HtJf9ByiDgZZ6C7T',
    'Maharajganj':
        'BBWqg7Q8t0yBmE4C6BlGjGpCsDhJjK/E6DnUzZva9FqB1B6SzYSc8W/V0T2MiBoHkH6GjLE2R6IwGuJzGkV2DqEzMgG4D',
    'Mayadevi':
        'BBOgk7Qo83yBvTxRtNE9I+H3NrIzMzcjEmMtOhC9HvJkFmlC0HkCoDzJgR1G6jBuD',
    'Shivaraj':
        'BBei7+QkzxyBavKhLF/E5MiFfzBzflJ4T1ROlH0HzdsJlK8QnMkCE2F5M5ChHgF7S5IpEmfqH0PgJ+JgGdA6K0O2FyJlOsYyBgI2GmLxD4BjGsJ+EkKjIka+C',
    'Shuddhodhan':
        'BBRm96Q4n4yBiEpBtHhEnjBsH5MhFvUsHpD0JrJ/G1B+JrW6U4HiGmI/I2PyG4GpFwV6Iwc9RuR2J',
    'Yasodhara':
        'BBSyv5Qwx2yB9JzL6GrKpPtCtDvHqGhJiL8DqBvhB5E5DrF0LnHjH1MhB1K6tB2BiW+HwJuOiCkElM4L6N',
  },
  'Kaski': {
    'Annapurna':
        'BBiBo7uRwlmzBlLviBzJ7Kvc2Q1hBhjBnF1MxIa5XxN/KuI6BwHtHmBiDzkBxOiOtQ8B9YmehK/H3EiIlHxFvLujBmHqUxFgR+TpBY7V8EoBqDxLsOOoG4I6eOylB4UkIvK6X6YmY8J4QyUoXlD',
    'Machhapuchchhre':
        'BBf81uR29nzBlClO7XoExQvUlY7J3YlZlH8KxlB3U5eNnG3IrONpDyL7FatC8IyHsO5D4OkGqJtFuFyL8Q6KmEF8NkI8ItIsK2dmdunB9K6nBwWyN9EmJsF0P7P6O9c1B9O',
    'Madi':
        'BBesqtRgrrzBLhlBnU6C9nBvWpnB+K3dxd9QgI5M0S9mBvHcuRjD8CzB/IToGsI4M9TmeN4a0HqKwP0EoXjBoQjP+qBoT8TnCiUqTiLeiGuMiM4H+GzKwErtB0KrC4DpO',
    'Pokhara':
        'BBpBqppRu/ozB8HpKhIrIG7N5KlExL7QuF9EjGhK2D1OxJ1FnCoF5NjCwF9b/W1XxLuLsB6MrL4LK6VpQsUpPmELmfjH0NtG9B/JwIDkJ7FVtLsb4SmSmFmSoRjL+K+EuIsQyKoCgLxMoB1L2G/B1HpWsDuH4BtU+mBwH6MzS',
    'Rupa': 'BBNyzmRipszBZ3bzJYzJtR3NjE5LyL/GnH5H2uByCoX0P9GgKgHsUxJqFuD',
  },
  'Kathmandu': {
    'Budhanilkantha': 'BBK2k/Qmtj0BFpP9LnE7K2BxJhG9F4CyB8EvRGoMqV2oByE',
    'Chandragiri': 'BBHyw9Q4ug0B7FxOlXjFxPsUrFiSyTmDwJ8N',
    'Dakshinkali': 'BBJil8Qmth0BzGvK0C/L7MhHhIwJ/V0BzGsQ0V+RiSd',
    'Gokarneshwar': 'BBKun/Qw+k0BZxoBjsBxDvSjJ+FsU6HD2IkQ+M+EoFyYqM3B',
    'Kageshwari Manohara': 'BBLgw+Qgil0BlFhQrMpE1IjQ5HE1G/SxN0BkOga0XyWiD+LqKC',
    'Kathmandu': 'BBN2+9Qg9i0BrIpQ+B5TlJ+DxDtGhV9B9C0L+IgF/P8b0NuL+S1DsH+EjGxQ',
    'Kirtipur': 'BBGs68Q8yh0BnIlOxTlDuHyK/HyMwVuH',
    'Nagarjun': 'BBL2i+Q8wh0BoChD/H/BxFvhBrLwH7RkkBkE3DoNmEyDuG+IhErB6I',
    'Shankharapur': 'BBJ65+Q4xm0BrKxrB9MyCjD/LhPlM/FodmGqfmSoI2DmR',
    'Tarakeshwar': 'BBGoo/Qoyi0BnCzUhXxbjW8kBgeuLoBxE',
    'Tokha': 'BBFqo/Qu1i0B7xBtQuKuUoDlEqeuK',
  },
  'Kavrepalanchok': {
    'Banepa':
        'BBP688Q8qm0BhB7J5YxHjR1UjJ+F4C6G5IiEsKwbkN2L0KtDmGgM+F3NqI4NwD7HpGjH',
    'Bethanchowk':
        'BBPsl6Qynm0BgIzEzRhS5BvZ7iB2CtWxVoH2fmUgTtGoNOoWiXoSyI5BgBuIuItO1J/Q',
    'Bhumlu':
        'BBXm08Qigp0BzK5C9IsWjK9ByF6CvGoD5E1EvB0KnLuM3F7D5MkJiMkN+FyV4PTkF4QuMuEsI5FxC7MsHxjB3MzSlJOiMpFb3K',
    'Chauri Deurali':
        'BBP+87Quls0B3J/T3PU9FxVhMjNtJqDjK8QwByH3buMgLmNokB6EgCuMmWyVgJ3I5BvP',
    'Dhulikhel':
        'BBRi18Qqhn0BlE3J9F4NlG/L5KsDjN/L9EcjCsO5EpKlN0KIqG5OjEqNwKqP8aqMuFf/TsT3C',
    'Khanikhola':
        'BBVy74Qi4l0BrP3M1O/kB9NvB9IsG0EmI/N8J0EqGjE+G1H4F3D9D+DoN3E+P6VqQN4F0ExE+IiKuX2HNvMsM/JlC5R',
    'Mahabharat':
        'BBd+h4Qi0n0B+JpHtX1H9IhK7EsEWxFpV3OIzLnDsEpF1DlE6JsEsI5KgQuD+nBuFkIvMqJ6G2NzEkK8EmJsRxE4VmMwL3M0H2CsHpG0B1YxJxFqHKmEzGvLvW',
    'Mandan Deupur':
        'BBQuj+Qw8m0BXjHrLlI3bzBlF4K8M2gB1YiefmI0K6C/MiO4CsI6W5IqMxPoHpY0KtHvC5W',
    'Namobuddha':
        'BBQ+j7Q8jp0BlOzNmGvBsEnS5NxVrRzMpFwPxS6TkE2IhDkboNjIqEyH3OqZ0S4E2RzPiG6C',
    'Panauti':
        'BBb207Qujl0BuE3CxK9UtHwJnJtGkIlF3CjJ7RPvGnJhLqK6B4HzI+PoCyWkS0T9XmR2JgRgC5E8SoGHpGmNzK6EqKkCrOwH5E3MlX6IhEpD7EgF5H',
    'Panchkhal':
        'BBX2i9Quzn0BlOrSKsFlOgGjGiKrT4CqB8T/IhFhK8CS6J/F2CqOkMlOiXqCqT8F1H4F8DoLtMwBzK6E2EwGnDxF5CkK+B+Jxe',
    'Roshi':
        'BBd235Q4rp0BoEtErE/HnKsJlDlEoDlYjE1IsN9NdxKxI6B9X/R3JqFK2MxP+L6L+PvBkLpKwByJ6FxB0YtHsGzH1CvL4M4CyHxIwcqc+KwKnU6VvRG1H8LtD',
    'Temal':
        'BBQ+06Qwuq0BuDnRpGnItU8QzP3FhL2DvC4Jla2X9IiWyHiLyCzHoLiDkcxMgRxK9BjHwKtR',
  },
  'Khotang': {
    'Aiselukharka':
        'BBRo43Q8//0B2F7IrP1K9EvJwCpLzK3LrChsB1vBcoE4P6NiI2BgJ3XkG4Vka2C6WqfgGuLwK8K3C',
    'Baraha Pokhari':
        'BBS4svQ8ig1B2DpFnFzVpHvFwDnGtMtOvKgG7UnCrY4GhI+fqO2YmBiiBuMrEiOtTyS9CzGlH0F3PuD8G',
    'Diktel Rupakot Majhuwagadhi':
        'BBRqz1Qq2+0BlE/KnS0W3NhCkB7S7Qpf9WlItQmLC4PzS8KgJwNS4UuV2d8H8b4a3B2KwL6VlY',
    'Diprung': 'BBKyuyQ0/+0BlH1ShW7IxPxZje0RyGoe2lBqiCyTiFFniB8LlV',
    'Halesi Tuwachung':
        'BBbsh0Qk/70B2DxE5GlBV/NzG5G6BvSpV7T3DnVjOvbjThNL4LhR+IlCmJ8Hga2M+K6K4erO+qBrZuemCwG2MoSgSqH+UjLHxPsI7J+ekH9HpWgIxJ',
    'Jante Dhunga':
        'BBUqkwQu8h1B9BnHjJpCmF1JvQtnB1TsGxD7GzF4P0GmHxS+ChOuTtMsE2GkJ/ByM+gBuNwKNiHxJ6NqGiI/NiHuD',
    'Kepilasgadhi':
        'BBUm63Q+vg1BP9JhL+CtLvKpf/F1C5WvMzN3M0tBLiX5VmYN2VwS+KmIkMkR3W4JnBuDvJqI5E4IqEqO1MmQ3C',
    'Khotehang':
        'BBNoyxQmmh1BhoB5rCxGnetJ6Mnf6EuQ2amD6a8P+lBlF2JiN4GxHmOwQgJ2I1E',
    'Rawabesi':
        'BBO8z1Q2k+0BqPpD1B/IhMxF9DnPxMzMlSO1N5c1Nid8Ys1BjB8S4NiCyStV9D/F',
    'Sakela': 'BBNq5zQ21h1BiOzN/ab9H9b3WrgB1JkQR4mBzR3GsBqL4PgPgLiBgH9FgVyK',
  },
  'Lalitpur': {
    'Bagmati':
        'BBU+p6Qimh0BnPtQzFoMvO1KnFyIxXyGxVklClKiK8C+F4K4D0IhQ6R8ED3XoSzF/EpPuJtCwHsG6L7F5GpTyMmC',
    'Godawari':
        'BBUy27Qgmj0B9BpOpCyDtE/GoEtM5RxMlBrHlGkDvKzT1ExBhIuS/KvEqEifmLdbic0L8VqSWmD0G6J9SJ5L',
    'Konjyosom':
        'BBPqr6Q8zj0B/F9JHvdvJ+DM/K5L8FvHrGtJuCkEiSpO4Bka+IhC4JkJ4BWoPoNI',
    'Lalitpur':
        'BBRs48Qyti0BsD5KnMvHxHoDxKjJlG4GnRYsG8K6FCnEuMuEgHqCzDuB2JyHPqFzKoJJ0C6F',
    'Mahalaxmi': 'BBL6u8Q27i0BtDhGvLwBnC2JpNkHpK2hBvI0C6EwHqJnC+K5U0WjW',
    'Mahankal':
        'BBT0/5Qwrk0BCpK/I7CP3O/IpB+BlKpY5IvFuCYqWhS5ErIgQnN5GvDoKoD+H2F3FgRuFkC/GqU6W2jB9C',
  },
  'Lamjung': {
    'Bensi Shahar':
        'BBesooRqlxzB+F/OpGrS/K7KiIpDZ9KrEqGzFzD9BrQvM+HpD9RnPvQ9F0E0FiUtNwD8CqI5JqXuG8F9FsI4C8F7M2DwMqO1EuF0NyI4Y/EqBxMnM+DP/RqMzJqEkM',
    'Dordi':
        'BBiB2zrRw50zBAvGhHqCzN5U9fvJxGpM7P5KxBtRpQrdhLlM5HqBxV3Q9DhM1MyJQgSoM9DpByM3YgFxerLwF8jB+IjG6GgEkCvLuPyBrCyU7I2M8D8QqcxBsvB6jByK0NrCyR4M4DM+GqL+I',
    'Dudhapokhari':
        'BBW0npR+i1zB1KxPhmBhY1H9KvVpDtIiE7D7Q8I1MsCxUtPxBjCwLnNrBzC2DwJkOnC0MhXsHqYujBqbkT2QtEyV0L8RlDsTiI',
    'Kwhola Sothar':
        'BBTihrRyntzBhQ7N7ToC9qBnTnQkP/jB9BvB0e2GyFzHwIgNyQqD+RqS5LsQ2IlFphBwIhF4LwSiDtHiYhDuDnH',
    'Madhya Nepal':
        'BBTk9mRo/tzBgGlFzGtF9BrOsF5LnJpP1JyRpFtDrUyJ/J/GhcgJuZk5BgOwBuFnEnDvGgNsH4HjCsB3WmGiE',
    'Marshyangdi':
        'BBnB86sRioxzBrE5L7TtEpJhL6CxPtEWzF51BoH/LlJjO1OxGplB+UtDoHhYiDhDuH3LvSvIiFmFqhBpSjIpD4IwEwGrE6B8GoGsEpGa+KhIqDsL2LuGmU9ByOma+mByBuR8P6KyGqM+fwJ0N6UwZ/U0DpJjH7KlGvlBkYpS',
    'Rainas': 'BBLq+lR47yzBzKjZzDrd1O3D1iBwfoN6D8H7FbgW+H8R4JsH8WvF',
    'Sundarbazar':
        'BBTs4mRg8uzBnC5QjJ/HrB4W3HkC/MrHoDwGtFoE/NvBsG+sBnK4XyjBqFtL1R8M1D3C7F+FrItG7F6JpX7CpI',
  },
  'Mahottari': {
    'Aurahi': 'BBIyxtQ0zs0B5HxapJlCLnOnOxM3JiV7N3D2JyV',
    'Balawa':
        'BBQghsQm0s0B7DzLnV9J9JzNhH8C1KpGtI2EoHoJjB8InPzFtC2DJ0J0JmIyN7HsSgJqCnF',
    'Bardibas':
        'BBf2zyQ+ps0B3SlVxa4CzBhH5xBzc3H0pC/UvL1nBvI8DiKvSvG1CsK4P+IF2I1JtEgOoNtD+GqjBgK0BtHudqDiN2JuG7HqCgL2LqIwJvGmMuBwOzT+ID6HlO/L3MuM5QkI+E',
    'Bhangaha':
        'BBT6xtQo1t0BzOnQyJgEG1IzPzIqEpLlM3GvUnBSkP3JQ6B+N9O7C+FgMiHnBzKiPgFoG4d0E6K7BiClN',
    'Ekadara': 'BBIq0pQkvr0BoBtbhduC1E+RgN3CxC2H2LoKuHT',
    'Gaushala':
        'BBO6yvQu8q0BEzI7kChWxByN6HkH7FsRxS9HzD+H6H6EIiO4IsBuI6U2kBiFgVwL',
    'Jaleshwor':
        'BBT+jpQ8/r0BjIjM0HlDpF9DoD7GvLkE4B7PzHdrHyCtImevNiKVmIqM6BuJ5H2KgHwDzD3C+IyGcyKzK',
    'Loharpatti':
        'BBQ64rQiit0BhB5N/TjEtE8EnQzIjN+H9GpJrGsPofsO2E+L8QiJyHL/DvE2K9OjHkB9F/L',
    'Mahottari':
        'BBPkrqQ48r0BpDzH9Q3GxFqInQtFnFwCiJ0KRoKrG8FgF6ImEnJ6N2E2ElCWzRyPuF',
    'Manara Shisawa': 'BBJ68qQ+wr0BzBxhB57BnGnWgQiGmDmP/IyRgEyDzEgEud',
    'Matihani':
        'BBPshpQowt0B9IvBtC9JtH7DgK/JtF1EiDxI3DsD/K/GxPsHnEsM0OyGqQuaqJnFqEuF',
    'Pipara':
        'BBQwqqQost0BsJvDze9LuFhKxD9C3K2DnFtFlEoJzH1J3MoTuH+DuC+JgJiBiB2L0LnMwOmE',
    'Ram Gopalpur': 'BBMsvsQgir0B9TzClBzHxI5DS+W9WvNXmOqNiTwVqKkHzKpK9Q8N4D',
    'Samsi': 'BBLujsQ8gr0B6NtE9VzMTnInPsInQREgOgK2BuG4L4GX/D/U',
    'Sonama': 'BBL+utQg3q0BsFxE5HjHjCpS/OrFjFhInNwC1N4hB+cgU0D9HiSqI',
  },
  'Makwanpur': {
    'Bagmati':
        'BBiBu23Qqlj0BVtFniB3NvJ3d/gB+F5OuVpKwmB5NRxCuJvE1EvU6C5G4f7M2Fb0SyFkFqElJkEuH8GvCB4NqGzFuI2BZ/J8d1EgKjbkX9LmHuEwCmN0IgB6EgMkMiH8KjMtE5GgO5J3DlV',
    'Bakaiya':
        'BBiB0z4Q+lg0BxEvHzMQ7EtK3I2BXqMtSwJlT5ChGtY0CzT5RVenKrJzD3OsFtc6iBc2lB1N4LkD8chG6ZjH6GhBmU8RoFyCtJ6NS8R92BucrM6MkC+BqTkImLgiB6PuEhZkKhN+B/jBuFd',
    'Bhimphedi':
        'BBiByp7Qq38zBrOjLzJ2D1F+K5EtOlGhB0B7K3H5D7kBoFV0R1G0KrF/B5CuMsV6JrH4YuN9I+IyOGuUlI6T7NJhE0XlJ+IekPyM9IoMKoFxIwO2K6FpO4E2BgDlfwMne2FW8C1bqJvH',
    'Hetauda':
        'BBgB6x5Q0y7zB/MnTkDlLlLvDwE/LxSrFjJie5P0M5oB/FmD+DlHuLwG8Q9HmDP+KwI2VjC8Qna+MrC2IsJ0DdoK8RYK6cmchIzB7NoF7E7F9IsM/hBhD7G0apRuF8BmHhcuWZ',
    'Indrasarowar':
        'BBS6j8Q4vg0B0HxK5WlKpJnL0NnVlSyF9C/GzUrB1M6e7C4e5EvBkH0KwMgFqB+FsGxOgWzB8HvJiNiH',
    'Kailash':
        'BBVm98Qsw6zBEnJxP5LrIgIhLtL9PA7HmKtQvI5S+RJgSrPse+SyEzB8KmGiB6EuO2F9K0J1DgbiNyOvaoWhO7EtK',
    'Makawanpurgadhi':
        'BBXmq5Qqn/zBR7YjIrMlNiJsH3YrV5JK1JpYgPsDsGrMgiB8F+InF8E2B6NtaoIasO0TwDuSvJYpM4I1B8EuKgRyCkD7KoNoB',
    'Manahari':
        'BBY+n7Qij3zBlc7QK8KzOsV3Cma1IOxKiL9bpH/OrOxN6LkB4O/LsLRwPrOsPtIwcioByGsMrIiNxiBiTqF4GnWqR/UsHzB0FlNwL+C',
    'Raksirang':
        'BBak48Qsm5zB0DtMjN9R2J9E7StP9F1OoFkBG7IxL9I7RqL1VguBvL9CzFmNrH0BpRgVnLoiBmLwD/C0L+OmPgThvB8OjHgNmJ0HjKqHR4JiB+J+K',
    'Thaha':
        'BBV+n9Qu99zBzN5d4JxC/E7EoGlMCnNrKhOnWiO7NianN5CzIqfpJwH3C8Z8OsC+CgHmSxFlIyHnDgTmekQmJtKtGhd',
  },
  'Manang': {
    'Chame': 'BBJ62tRk2tzB+MpIzkBxY7I1MxIyBvEstBvGiMwkB8UuM9M',
    'Naraphu':
        'BBqBou0R8oszBjRtSoK7Q3EvJ+DnMzX5GpE1UxM3CtIxOhRmGlGxH1RW5N2VyFmRrDmRlNhBzJqHjWsnBxWqEjfsd8kB6H8PkVgHkXwR8EuMonBmK5BwGoR4SnBoB4M8OuFmFpImMiC0GnKZtLkOwFgExIClYyI/ItG7L8IrWgN9N1E9H',
    'Nashong':
        'BBlBw8xRiixzBd/JrSuBzE3PtMEtMnnBvR7E/GjX7PjVhVhH7X4L3CqVtM+MvrBhctIgGuEw7BuEV5CyPqJiLmMcgMyJnGiSjYqSmGwlBkH8KkZR+Q7E6CtHstB/CsP9OkHkCwG/FgN0E4C7LoM/LmKqG4HnH',
    'Neshang':
        'BBjBo6yR4hozBmLpHrChKpazClL/Z3Q5DjN9Q2C7L7H/TnN9O1Y8lBpZ0NxHkqByC0P/MgQ2B+O5O+czP8PUwgBpRoQxF0OsEoI6jB8Ykfrd8V3D2W5nB4JtHmNiBsDlR1FnQwE3MuJ7J2RVmGyHsK3D',
  },
  'Morang': {
    'Belbari':
        'BBQ05pQmis1B7DpM9Q5L/CvIvMhClRyGvRhP/lBsMsJyPxBoQ4K2InEoIwZ5FyqBiN0DjOsOwE',
    'Biratnagar':
        'BBRi6lQyjp1B3H/GkGzC7CtV/UnI/KiFlW5C7H4O5TD0F8YkCpF+OhB4IkG8PnBsShJsDwSgQ4D',
    'Budhiganga':
        'BBP25nQuyp1B8GlB3GlEkCrKpFlElfhGvX1XhBgFpJnB8CuV3FmE8jBkNsLyPsO6BgFqH',
    'Dhanapalthan': 'BBLw9lQihr1B7fxbpRLfgFnSqD8GqMiCwY2NkYuN/G+H/W8OM',
    'Gramthan':
        'BBRs2nQq1q1BpEvXjPpCrMnQxc/J/F+c8MKckP4GtB8BoFxImCD4NmR2CwM1I0C4D0QjIiCuE',
    'Jahada':
        'BBQsglQykq1BjUvSgC3OjLuC3IjG9OiBjCqFpFhKhFqHoD8G5O+RqI6K+QlBuM4HoSpDgB/E',
    'Kanepokhari':
        'BBNk7oQu9s1BgF/C1rBjMvZ6F+BvMxZzF0BqUgLoJxJwIUkJopBrE6TwLoUtB',
    'Katahari':
        'BBR+pmQuyq1BtBnG3GuBbjP7MJmC1M1N9DT3Q/Y0HzC0N2RqN2GgRgXqLqDgLkFpDnFnFgDvK',
    'Kerabari':
        'BBWg6sQ8jt1BqB1L/InW4HzT9CtSxMpOuCtNnSgBvU9Ptf8J7N9I9H4duE0D3B8N7RG+CuI8c+agNtGigBiC8NjGhC+d2P+N',
    'Letang':
        'BBVw1sQw4t1B9DpUpI4BrP1O2C5c7NkGhgBhCrGiHjN5HjKgUrOvE3C+NxEQG2xBwNjBlEwa0axSqOvU8uByIsFzGuJgE',
    'Miklajung':
        'BBQ60sQ4lu1BzB5J3H2JtJ/DrF0GnvBrIle0iB2CuHsLiE7G2RmaiX8ErRgNiKuKvOsKuDyd1mB',
    'Pathari Shanishchare': 'BBKo8oQ2vu1BlBtb9VoE7U1LrN+BrQia4MoV4Q3D8UuHkP/E',
    'Rangeli':
        'BBVu2mQu3r1BvKnUlJ4EvG/EpI6J7OL9HgXzQwEpLyuB8GsDkSjJ9DtEyQlO8J2GgCwJ8FtEgLkGuM7OhL3KzBpUgPkD',
    'Ratuwamai':
        'BBWyqnQgrv1BrB9QxJkE5SpN9IuGlK/HnG8DFjF3ciBjF0J9E5CjBiIlRuD7IvNtI+BkHuoB4HfmGyR8MQ8OrNydtJsb4B',
    'Sundarharaicha':
        'BBM24pQsxp1B5jBpY9Y0JjCqK2GyE3KgCDomBwOoMmRxGse8B4B7NtEzD',
    'Sunwarshi':
        'BBa0hnQmzt1BvBvFxM4F/P9HlBmF5J7G7FuE/BvJ7J1GxQmO+DuEjSkJ7GrDjRmd2J8NyRvDkBhI+E6CqF1JycfGkFoG7DmKgI+ItGsJsFxD5N',
    'Urlabari': 'BBN28pQywv1BvNhO9M8CyHxMhE/O7Y8XxjB3Hc6SpTiLoY/B6L4K2X1I4jB6H',
  },
  'Mugu': {
    'Chhayanath Rara':
        'BBkBksjSsimyB9GhYmD3WzOrhB6KvMvDpL3gBzHYmgBjMlCpK2H7HrBsDjT5HjUmOnOpXhGpFtL7IkEvOshB+BwQ5O0LqHyRpI6HtRUrOqZOwSwNoFwGgLmC4hB4W6HyJxDoNqKkPpe+LnDyOyEzH1P8QlP',
    'Khatyad':
        'BBcwiiS2+9xB8OrPvC3InH/BpGsK5WsFpfvLrCpLpD+P5cqMmE+kB3KoL5D6cqF8U+QoJA8QjHkF2N8S8LxZ8IjEuOoIyL9K4GvQ3GjSiE9MhEpKgHpNpD3P',
    'Mugu Karmarong':
        'BBlCq8oS6ysyB2Fd6JjVzfnkBtNlCrGzMxOsJ7CnR/PlDhMuFxGxXnRuHpKxJnSwKlL/B9KvLgMlhBnCxQtMtTyG5MtBzSlUsDjsBhKvRqP0H2PxOxE9LoDhJ6WtLuHjKmd2GyOnhB+ShB4PsLwGmSgbztB2K1F0coIkoBvQQhIsLgRmc+H8BgEsP0W6MmHrH4RoFkEifmXwNgFgKitBxP+KuUwZC6HjH4LsBoGriBiHsCuOhJkD3RzEhVwRwCgBkKgN4Q0NxGmC/JqKrItN9jBkC1LyUuN6LhZ',
    'Soru':
        'BBkB4hlSmwiyB9IzU1TjOlS3cyBjK1IhIqCtR/d/W+BvrB7U8fzPgMqD4P/GqNiEqKhE+MqE2ZxP6T5KrCsB0FkU6B8DiG7OuM6HkUrDkT8HsBqK1HkMmCXlgB4gB0HwDqL5KwMqL6G+HhI0U1EyShUkLR',
  },
  'Mustang': {
    'Barhagaun Muktichhetra':
        'BB0Bqo3RimhzBlFpEremB5D7PrPxFhHrNnqB/kBtTuBbzM7hBqDwD+SpE8MoQkcIqXuJoH0NxBgKie9DsRpN1BzT8J1D2sB9EoChKykBzJqEjIgU6QiKuGiU2WLoGwHR+FtK8ErCkR7JkM0P0UyM4CzB9I8MrK5BpH4J5O+WrI2HxOoKnF2DtQ1LhzBkfvDH5GuK1D+Q1XyB3N3HlK2InT9CrT',
    'Dalome':
        'BB5B4l7R2zjzBElU1T9Q3F1RvdsE7EiI9P8CUzMtMtGuBjNpFpIrL2J1KI9EpIxMwGlDqTlH6H8C0TzIkS4HiLxB4NphBimB7X9C0K01B1DuQnKoF1HyO9WsI3J6O6BqHlNwLoGwc0X6G9DoM4EwJnK8QyR4Q9D+ZwNrD08BiR4TtD6FtNjEtTkVnC0JpZ1MtOwC5E2hBngBqL7DkJhOlGjW9gB7N1ThW+TrIqpBznCuMvM8MnD',
    'Gharapjhong':
        'BBdw6zR6sizB1JzgBzNyBtJnHHpX3EvC3GwVlkB6X1EwQ9Wve3DkP1LkHgBoV+HuM5DkLuHmFboUiQ0W8HgU1C8LkN+Q2EJkI/T+IjD4K3lB+EnC2D1sB0T7JqN2B',
    'Lomanthang':
        'BBnB878Rs9nzBhJ3K4Fla9JhezHrF4CjWrPrLjR4B7D7ejGA5M0XxO+EtMwMppB0nC9TsIsT6VknB0VK0OjJiOlfgUpQ2U2M2OpI+akNkI0MPoEpQgiB5HwNwJuE8NqQarCrlB+ExPoWsCqJlU5F7L2JxPvJ9K2G5WwL6F',
    'Thasang':
        'BBc0xyR4ugzBiHHrPjbsC9U7RigBtL0B9VtN1IyBvFzH/UkKzGkLlXyB5O6J2DyKlK4chE/CVqNwuB0dsJ2O0O8D6DjLrGnHrD7XwM1J+CvO4X8d2EvQmkB5X',
  },
  'Myagdi': {
    'Annapurna':
        'BBgBqrwR8ykzBAzevOrKxHqB3ZxbldhOH/PiEgDuKjevI7MvP6J7dtKhfuOxDuNlKjLlZrE1GqV/TmSuImL6W+InDwsBuHlB5BvHgLtI6XyNyIZoF2M2hBijBwc1Q0J8KmL2gBqZzN',
    'Beni':
        'BBQm8qRsy/yBpDzRzIiB3DvPFuIlH9BlFsFvHxPzTuF9DoYrHkF0ImR3LiY2KxCiQ/RyVa',
    'Dhawalagiri':
        'BBtB6pyRo/+yBK/L7ElC7NztBwB1NhSxQsC3W/Jte6LrhBxFvIpSlBjTnJfuR7D5B9UtlB3alI5SuYvCkP3L3GrQwJuBkL9K+a1OmOmK6PhhBgnB6XxFnB0QnGuGmD6PgJgGpHkbmRsKvD3JwHnT+NtE0S1U6M8Nqa2BivBsY6DwIzFuSgFqHmJnB+VuNqR7E',
    'Malika':
        'BBXossRqr7yBtKhPhHuCxHnG9CjLxHoB7I8NlenLhI2UmK6OBmRjJ8K0ZkIyE0H5EgNwRgC4DsKgUjE+CxK7EzGoGtGoBzQ5XyF',
    'Mangala':
        'BBTirrRi89yBgEjElG4BtDlKvR/B6E/MxEzHpYxFN0Q9RkUrF2aqUjEwHyPmFrFmH+BGtIqG6R2PjRmBjP',
    'Raghuganga':
        'BBfkqwR6p/yB4FzPvDnIrvBzYpa1B5M7NzS2U9NuEvHoTwD4JtTrPqJxW3IxF7NqB7MmOlBkPzJ4NgFuP7X4WqPoSyUQmKkLyDtNiftO8duKqJ/I4K8C6O5JmXxBmE/I6T5H',
  },
  'Nawalpur': {
    'Binayi Tribeni':
        'CBcy29QwnmzBPjVzPwB2J/nB9JxhB+FlgBrWmRpN3FvB+HqI2K/GuXW2e9ZjE7JlJlKgL7ByRtZByJ+GnUgW2HqI0BuOuJyE+H/GiI0E4nBvG+EqF8QtP4cmNBJlxEhM5DnOnG6GxWmC9C4I2HsUmJyFtEtRiUnF',
    'Bulingtar':
        'BBZ6+/QwirzB4F9C3IpI3MwC5I3F5J2IxNmBnNyY0JqOuF0YvG8TsQiNgC+QgO4DkM/ItD5O8IjRT5HzFtBmGtH7EvCyIxEAhS/H1KuFH',
    'Bungdikali':
        'BBT0ogRivqzB6BrK9M7P4EhP3JjFzMgE/TvQ7JrBjEgM4IgSlKuW4G8LrByMwZ/L4HkGkGlEwLmFgFjD/DrF',
    'Devchuli': 'BBMmw+Q4+szBhFnahP5QtOrD5MwH5JzB/KoFlKwPmKkrBqZlI6ayJoLzH',
    'Gaidakot':
        'BBQq9+QwouzB7CrK9O5M1LoG9a1J7YmIqWk2BvNyUoPqgBwgBtH+KpQ0B5MhP/GjGpN4L5OmOnB',
    'Hupsekot':
        'BBW6y+QirpzB9IpMkE/L1N3CjC/a9MtQjHmNjBsY/GYjD8QnSFrM2VpOmCnC8SkNuBsDyJoa/BtFgSod1B2OqXmNrYxF3Z',
    'Kawasoti':
        'BBY639Q41rzB8GEtMnW5Z4DhD5M6FzGhbqBpDvJjNtBqCtIhFlC3PMvIqJzJ7BtEwJX+GiIoHmagH4I8a6J2DsFkK+W1U6J0B6MvH',
    'Madhya Bindu':
        'BBamx9QijnzBzK3L3C6DxOrI7QuP9EpF1NqFhamBhIzEhH6G5InC6KurBzNwSwPmYrBiK0J8B2R9K0LuDBtKqOlCsM1VgSQsDlRkGMyEtMxChN',
  },
  'Nuwakot': {
    'Belkotgadhi':
        'BBPo3gR2u/zBpTnWhDz/B3G1HhVxE2EqSvM+GnOgnBzIkGwDuYuGsJwT2B6GyL2fgD0I7C',
    'Bidur':
        'BBUsyiRsw+zBvCnEnMkH+B5G3F5D0GjbrO8FhI3H3LgW/KnBjP/QpG1CxD+E+H8tBmFXiQqWoMvDmUoe4FhEsImI',
    'Dupcheshwor':
        'BBP0mjR+hl0BMxJjLkCzKzJ4FjjBhmBoBvHhH/TsHvGogB+D6dmamIka3D+QpRgHuBQwH',
    'Kakani':
        'BBPuugR+lg0BnOvFxVyB5GxLvT1BtGrJmJogC4HyH8EpD2G6EqC3E4CoKiR7GhEzHwOpF',
    'Kispang': 'BBMywkRu5+zBuE9H/I3ElGtV9kB3NuBwc9TqOoCohBqXoEoFjb0G1G6buX',
    'Likhu':
        'BBO4yhRqhg0BhJ3PnMwD/FxGhPu1B9P4HwB2FwPiGwJvO0MgEwB7XyFvBtDzK6HuC',
    'Meghang':
        'BBSimkRy19zBH3J7VtShCjb3R0I1F4RlM5BhN9MtBqF7OpEgG8kBoVKpJ8P6EqToMjHiHqG6J3JEjf',
    'Panchakanya': 'BBK0rhR6hj0BpE9yBjExFzD0D1K9EvOkVvB2buTc7C0VuVlH',
    'Shivapuri':
        'BBRq4gRi6i0BtTnByErhB5MpElRiH/Bic+MyQzHiJ2HuMpNuOwHoKjDkHgR6C8L8L2HjBjDja6I7a',
    'Suryagadhi':
        'BBOqxiRuni0BEpNnLvIuFne/HzH3FiElG9M1MwI1HzCgB0iBqQsETnGiKiBtByZ',
    'Tadi': 'BBJ+jjRwsj0B4DZzErPhO9IXjNzXjCyBvZ9WkE0Di9B',
    'Tarakeshwar': 'BBM6xhRun9zB9Exc7R1KvXjC/E+KnL2EKyFyGjC4G2H4DqWgVwRyP1C',
  },
  'Okhaldhunga': {
    'Champadevi':
        'BBW232Qy610BzBhIpJ7CAhY3HlExS0HhKpQ/IyB/XhX/HyQ6OsWxJqKsbyI1G8MwBsR8I6IyJ6G0KvNoHD0JmKclKiNpG',
    'Chishankhu Gadhi':
        'BBNwg2Qo660B+OxDuNtQvamJ/jB6B/CuQhRkB9CoegM+WyRhB8H6Lkb1EzIrN',
    'Khiji Demba':
        'BBQ6y5Qm120B5C5LjwBjzBzCmU/MsGrPoa/OrBmC6M+N6LoDkO8F3E6NqeiOgIqT9IqB1KiS9M',
    'Likhu': 'BBO2/3Qy200BhcpS/bzG3SmBvM8LiKqQySzH+I0FlB0W4KsEZ+UmG2DsT5b4M/F',
    'Manebhanjyang':
        'BBOu40Qow50B9K9sBvJ7B5PvYnLWtEnIvH2EpKsU/LgH8YmnBuEuWkUqW4T1C2BrR',
    'Molung':
        'BBTk33Q8s40BsEPnEnMjMtU7F4ErU9mBvHmGKiL3TuS+CoOlG8J7OuG2K8BsC+UgQkRM7S2H/DoV0L8Hlc',
    'Siddhicharan':
        'BBbuy3Qm940B0HvHsHsEyFhInY9I1ImD7HmctWxLdgFxFhBd4StP/QvChVlNoCtTpL0KotB5K0P1BsRjV6BwH8kBkJ2H+CneiRjBgDtQgkB5BygB/M0SrT',
    'Sunkoshi':
        'BBW4i2Qmg30B+GtFvJ/KpILzKwNlSnP3B3R2G7MnHsBpP5KtJ2I9F6cpQ0BtG2P0FoN8KdqIoI8HwQmdqOwRtKmG7J9CnO',
  },
  'Palpa': {
    'Baganaskali':
        'BBUizhR+qgzBmF7DtJtTkH5E5GhC3JyIhPcvH6S/K9F9I2H1F1F7IgGM4O+M+GwMwTwNiB2StGmC5HoFmD1B7P',
    'Mathagadhi':
        'BBf2rgR42hzBhS/V9M9GWrN7Y+BzFgKtQKP3KhMlKhL0HiD+GzFfvCkOxIgI2B4ThSqa+M6FiXvQzGwfqJ0d0KBqJlEwChhB6KnB0GnNkOjHmD3emE+NwD0D6G/DsB6G',
    'Nisdi':
        'BBdoigR4lpzBqDrGxG8Bb7P5NhI3LoDkHhLJ9MxKtU4MpLoCrM9RtF0E9TjNzOPrM1NZ0DlH3FnNxC0F/SwDhJ+rB+PZMmlBvFqM+MuQkCgbyXkEgUwQ0M/D',
    'Purbakhola':
        'BBfi3gRqvjzBuBrF3X5FxGwUjL9CLthB9I7I1OiJpG+MlL8BlC0duHmL5D6G8NmBQsMkN0OzE+T+RuF4C2IqJhPtD/KkF9FrQ5MgLvUsQoBwBnM/GrDWxF+K3B4ChGoGqC',
    'Rainadevi Chhahara':
        'BBhB2hiRsv8yBhFxU5QvEgCnSxJlH1FwI/HpBzIsNpJhIHxKlF+FxOrMoCparF3KnJwKtLvB/CiI3RiBAoQgH2KNoQ7F+GoPoCkCqG8nBjETiNlHgFiKiHkNAtGoQoRiEiVvQmOP',
    'Rambha':
        'BBY4nhR6tizB4GlFvPpM/B5N7duNvDiHtElH5GgEvDzDrEzN7DsZiKqMMuhBkL+CoItUiW4FRoMxGjC1CiG4QgCgD3H7EnByM7OqCtS',
    'Rampur':
        'BBayjhRy/jzBNhErdxB6CkXpP3BvHwKzEmLkQmL5E8G0DmKnb8eyKuUK+MjHmL4LrD+P4KkI1DgC1csF3FjG/IyMxdnJ9LiFnInIG6FrP5CxI',
    'Ribdikot':
        'BBZy0hRk88yBuDrD3KGhVwQnRhEuGnQjNAhKhHmH/Ec1MjVA9DoP2GoH9SuXwNuGnIoPyDkC8DjImC4S4JmGwoB+BmLtNyB9P6F2GExS',
    'Tansen':
        'BBY4yhRon/yB+D/HnHC3D9N0KngBxFjIjEmV5F1GxB+P9KoN9cqCrMxECgJtFpElFmNvIWzCgV0M2VoNzKyF2FiJ1HgL+FwH5SoPf',
    'Tinau':
        'BBhBmx/Qq7+yBF7InJ7FtBzRjIiFoInPvNtG+StXxG3FuDlQzSmDjCpGnPnCrOoTyI4L3IgK8CuQxJ8GoDgsBvOutB0FgBhD9GiLzHiMmKG2K4QHyF/J0JQmFrE9HvQ0C/UwIVmFlN',
  },
  'Panchthar': {
    'Falelung':
        'BBVmh0Q0i11BwC3H/IhI+CvN5G9FsDhOzLzC/HwG1GvHnTiD9CoStTmQ3D4QjNtI+HqeN8Y8PH6HkKqRuH0cnE2D9tB',
    'Falgunanda':
        'BBOgkxQkzx1BuITvI/HmGnZ1EuCrI/KzZ6LgBzIpFtC/YsakRqRnEiY0Z0pBiOl+B',
    'Hilihan':
        'BBP4/0Qq+w1BN7IlN7EvfgsBnLnEjHzQ/T9EnDmHmJqTZ6RkLiNoEyW8hB1F8DzkBoP2E',
    'Kummayak':
        'BBO4jyQ22w1B5F1c3I1G7Lhc9mBhhB7CurBpNqC9DuGoHutB0JrOqFuCf0I0Z5LwIiL',
    'Miklajung':
        'BBU8yvQg6w1BnE9pBnM0DhEyMhND9T9oBqBvPyKjHiJ3RlQpCrU6G1K/FAuXzP+OQkhB4MogB+Z0DoE2HmOlS6a6V',
    'Phidim':
        'BBS89yQutz1BrBpRjLhNa5R9GrHctTlJlNxI4DhQjGrG0XwIgI3RkGxNq+B2E2JqgB0jBkEhRuSnO+DlU',
    'Tumbewa': 'BBMmiwQw2t1B3OR/RhbnY2lBlKyG1BiQ+T+oBsNB4DrMmLPwDrOgOlC',
    'Yangbarak':
        'BBa253Qwm41BkDpErP7S30B/U7chhBmCpjBzEvPuE1ShI1mBxOpGtDskB/J6G9CuN6G+F7CyNiJgJzN+V1D+tB4UuL0WS2EmI0GhC4T2PyWxPuZuF4IyS',
  },
  'Parasi (Nawalparasi West)': {
    'Bardaghat':
        'BBYgs8Q88jzBJjHzfGzQiJngB5Q9D4MzShM7EkElI1EpFuHkNqOnJ+DqCqRpFiJyKyIzE6L8b2ToU/VxJ9GuZC8BxRmK/K8JmJ+ZkE',
    'Palhinandan': 'BBK2i5Q6jizBkBtF5K9CoEza/IG7eg9B4BqK0XzKsFxJgI4B',
    'Pratapapur':
        'BBQs/4QikkzB5SvO5I2H/HvDlGsK5FlIiDjF/HhCnT2pBkN6I0R5EmDyKsE1E+QiH0JhWpCpR',
    'Ramgram':
        'BBW236QushzBhHrMwB1JtRoBjJ/F/HoHtMxCjKklB8L8F3IyU/H3BrD2FqV2JgE/JwVK2C1E4OuELvHnM3G2GhInOlCsQxV',
    'Sarawal':
        'BBWgj7Qi5jzByE7CzI3L9kBpShQuB7D+JzUhKtZoPzC1KxK4WgIiChDkF6FmImGrKgIwDqSlIwB3GmI2E8EjE0SiM+D3MogB6Q',
    'Sunawal':
        'BBVw78Q+vhzBhRpDzetjBvZ0E1BoSwHoM9KZvQyWsOmB1GiIoM4GW6GhP3DrBiEieoRwJmMojBbyDxNrI7KiDhP+QhT',
    'Susta':
        'BBUqo5QupmzB/P1UuEnOpJ3C3E2L5QjHrE2ElDxKzR6EjN5I7T0fqH4PqP0LoEV8BrU4VnDsGwRkbvGkFvG+FsO',
  },
  'Parbat': {
    'Bihadi': 'BBMg9kR6nhzBmE1K1S5JrK5RhSUbqK7O4R8FoIkIvCoBwKwRJqDhK',
    'Jaljala': 'BBK4wqRm4gzB9KrRzTfhUiUja6DJ2OqJqH8B2N2gBdua5V',
    'Kushma':
        'BBS8uoRshizB7B1N/FxBhC7O1FzDlT4kBtTqF/KsuB6X2kBgGxI3EpiBkGjEmH6E8DtJvLlI8TqFqGlR/HzG',
    'Mahashila': 'BBKsslRi6izBwBlZpT5EchU/X5CjGwY8DoKqJlH2K4jB0GyG',
    'Modi':
        'BBW41qRk4izBPlHjRpFpPzN5lBoDtQmNgI0GpGmR7TpFwLmI7DuJlH5EjGkE4BkhBmQgS+FlByIriBmHyF4EhIiKgI+YleuQ7B',
    'Paiyu':
        'BBRwtkRi+izB8GrDtIrItBxRpJmH7DnKmFvP9QInBvK9MV/D0H0HgF1DgNwJyX4D2CuD7FyPiP',
    'Phalebas': 'BBOk6mR8mizBzQjUrYL/O3ShH2JP4SqT6ExByciMgOpBsR+E4D8W/EnFvDWhK',
  },
  'Parsa': {
    'Bahudarmai': 'BBNy3xQi84zBrEpLxNcyElMlK9EtH2F6CqJvFsExI/C1LgP8dqL8TtC1EvN',
    'Bindabasini': 'BBM46wQkv4zBnBnL/V3D6E7R1J0EhOvCsDuMxLkHwHmJsI+FyF9E0X6F',
    'Birgunj':
        'BBf8/yQqn7zBgc6GIpI9nB7LpEtHtHrBYyIvIhExD9WnOpBhH/H6IvMlRqCzX7MhG6ByJ7N3NhEtN+bxNc2BmPkSqTkK4DVpLgISwQ8KduLgInH6FiKuLa0JsI2WtG',
    'Chhipaharmai': 'BBG0pxQy81zBrP1UnSlCjM0kB6T/C6GzP',
    'Dhobini': 'BBKk+xQ6/1zBWrE5O5E1MiH1M/F1GuPuPiLqH3D+FyIuHvB',
    'Jagarnathpur':
        'BBSkjzQkl2zBpNjL3HkHzOjFhM2b1L0E6MiJhE6K7JECwE6T2GoBpZyM6KiNXoC/FpMxEwD/X8N+B',
    'Jirabhawani':
        'BBRum0Qwn3zBnY5JuD/IhG1F4HiC4ClOhXtGoEuInFiGnPnBtDuYoMkE6FiNgE5F0HcmMwK2PiB',
    'Kalikamai': 'BBLw8wQ662zByXpF5IuBxEvIrJiDrM5KjJ2DnH0XsM8J2KtFqJ8C',
    'Pakaha Mainpur': 'BBGgpwQ8q3zBtI7IoI5WpL5CxQglB2RwF',
    'Parsagadhi':
        'BBRu+zQsi6zBjavSepGxL7BxCqE9K9Mvd5DwFoK5LsRkJwH0LK+EwInF+JsK4IuCrJyKuJmoBiM',
    'Paterwa Sugauli':
        'BBQqk0Qm+3zBSnE1PhBlMvKzHb/D6FzE1KlQuEnHtJzGUHoXkQ3ByLwW+MdxGmKglB8F',
    'Pokhariya': 'BBKwvxQit3zBmEvJrT7LpFmGiGqL5XiB3F8VwXgFmOhIzC3M',
    'Sakhuwa Prasauni':
        'BBSsh0Qwh5zBlSvI1SQkHzJvNMxLvW7IsDvWhGjL0IkK4FvEoMwNdiFiN+ToBsFkL2TTdqGiX4S',
    'Thori':
        'BBS252Q2vzzBwHjNrFoCzC5V7KvMjRu2ChmCmoB3D8P5H/BiG2FrDkJgYwHGpfiRmF0ElU+P0QoV2FuGlJ',
  },
  'Pyuthan': {
    'Airawati':
        'BBZg+jRw+yyBnIxLsH1I/E0BnB5P7MrG5E7L7FiC2Cwf/G3ErJwJlJ7E3FoZ7R0atD0cmE6JpH8E8Q0D+LpF4P/VmBvNgImNgU/B+GxXhIjI',
    'Gaumukhi':
        'BBSgspRgr1yBhBtHhXtLlQmCzLjNxHiFvOrKlErLlH+HlDkS/IhB5D2YiNiMmbxJsFuSnGuQgaqMwatW',
    'Jhimaruk':
        'BBZ02mRuk0yBxRzV3PrGxB2E1KC2B0HvH4D8DmFjLsGXyL6F+G9DiLiG6ClJgQgE2NoN2F0I/F8C0E6HvM6GqD8D9H0FyDnIhL6DrYgJiB',
    'Mallarani':
        'BBdy+kRg20yBd3MpIvDoDzI1I/GkEpD1CvL8JpGuFrNvD1DzI6JpEjDwIpM7JhHnJ6B6JnSpFzDjGwIvHnD7FmHyBoQgFzBrH2IwJoJrMyUiI8HpF8RojBgaiGlB',
    'Mandavi':
        'BBTsykR+gxyBsKhI/TroBgMtKjY5IjD8VhLtNhKHpOqb+H+J+BygBoFtB6E8LyM+FuDlGwJuCO3FuIpC5D9J',
    'Naubahini':
        'BBbo+pR8i0yBrIrN/QtEzRpU1NtC1J/VxOkBvLhVrFiFpLzGrEyEhCwN3IqG/EyOqLqIvKuDjFmM2MoBsSsTqG5FgEsLyOuKoI9E8K+M8PpC0YiNuQxO',
    'Pyuthan':
        'BBf4wmRqlxyB5CrGrPNxLkHlTpOrQkP7GR6G+M5JoSkJ5B4JuGlIuLgE2E8I7JwD2DtFsN7JqG2CwLjEqD2IgHpBmM8PxL7DlFwH3D1BzHqP5BsF7JwKtDpLpIgFxO+I1G',
    'Sarumarani':
        'BBZ2ijRogyyB1Ex1B9H9J9J4DsBkK3ImC9LlJ/KgP9C7DrRkDzBqKvGQ5BwIyRmM7C6OoF+LpF+FkIqLhGwN2PgQ4Sra4FnZmJ8EsJvJgH4E',
    'Sworgadwari':
        'BBUg/mR8nvyB7OtKqEjBnBlPzHvUxQpL/CxKrR6KhQrE9OyP/KwkBkY6I/LuKkKqPL0MwgBmZ6JhHmPDO1SmR1P',
  },
  'Ramechhap': {
    'Doramba': 'BBNyq7Qist0B1VhWvF5N/KqN1VuGkEqezPiIuBifzO8f4OqEiF1XsWyG+arc',
    'Gokulganga':
        'BBY0r9Qs230B9PxVgB9OzG9H/xBvfzTx8BlThVrclKhLhMtP6WnCsQ6XyPia0EqKoMY2c0HCoIuJsD+QyRiLqIqW6afwIkRwPJ+ImK',
    'Khandadevi':
        'BBV0i5Q8mv0BgB3jBxN3MtCiEnGlE9MnPuKvftD3I5S6a/JipB7RkRsEgKvWsN+NuIL4TkEsBmezf6J+G5BsMyRtC4FgH',
    'Likhu':
        'BBQis4Qm300BqYxN6IxNnR3C5XxPoCrQ0Q7VtDvH7TvEhKrL1PsU6C6PhJ6awFqL3K4LqhB+T',
    'Manthali':
        'BBd8i5Quvw0B8B7J1UzL1RqC+BnM5J9Gle0fjErBM3T7WxIGwJ3NqPoKiLqF3CX6KuD1DmI0E8G2KpUyQsDyT/FQegFwPsL6aaKlY6PhU6JsLkXsG6MvN',
    'Ramechhap':
        'BBc8h3Qmjz0B8ErL5bHvPrLd/EgGPrDxTqUxQ7G1KlIzEtD2DY5KpF4C/N3LrNuVmC4LlJoBnF2J0C+M7EuJ5NgNoGiGvBud0LuFsM4QgczP0fwFkK3L',
    'Sunapati':
        'BBP6z5Qu6s0ByQ9EgLpN1O0ChShG/KrNtQqKhJ9C1JooB+MoPoGmEuChEoO8LiO5G1Dvf',
    'Umakunda':
        'BBjBst/Qm040B+F/EzChHnJ7LpOzFzCmH9YpHpI2KnU1OvPKpGrQ/cIpIpWxRhLrD9QnItJzHBX1ctO5OvqB8eyJmSif+cgDsKmbyNwLgX2OsNmCikBqjBucyTsBkhBqUsJtFwV+B2E9MzBplB6KlK',
  },
  'Rasuwa': {
    'Aamachhodingmo':
        'BBU8mpRk0g0BgK1QnK7M4E3NhzB4a5QtJ/LyK/VtFrDkOvPsHrQtF3MyQmlBgwB2FvFwW8VoH5W8e3ImQ9R0IX5B5J',
    'Gosaikunda':
        'BB0BktqR+hq0BjCxRlWuBW5MjTvHhJsE5cvgB2dhFuDpYiPviB+BpelGza3LjCzSvVmGrS2J7EjKlqB1T2R/doInH6WvW7VpF6FjPxQjUhYjGjU5TwQ2EsMjDuLmK2UvB4ThImQhNgKwL4DkE4M2LsE4PujByUWgS0aIyO/IsR8CgL/RgQgOqPwG8lBwHqEGolB2NsNmajgBmhB7JwR0CkZ5K2I4C',
    'Kalika':
        'BBR2njRw2g0BmWuN6TvQtH1LjMTrKjJzECxIgWjF9HgDjHhGmC7CjJ9O0CxBodgJsBXvMsJ6H',
    'Naukunda': 'BBN0okR60i0BzLxyBzOrL3R4DzJ3HsB2LrJT5E2ToLwIyDoZmNqHqSkiBmR1S',
    'Uttargaya':
        'BBYilmRw//zBzD1NvNjMjO3CvLpRzIsEhCwZ5btXzG2GnFkb7c5BwB0I+OzC8CkJ+FtC7CsHkF+HyI/VgPiJuI3BmP0XwM1NsQuFwPrH',
  },
  'Rautahat': {
    'Boudhimai': 'BBNo6tQyih0BpFpanSjHiO1NnJpBF9G5H8FPxE3F2G3Did6MgMpC6S0R/M',
    'Brindaban':
        'BBZozxQ85k0B3InuB3J5CN0KjG1HjFmIlItFrFmGhM5QKnWhJnOxFGqBvJ9G5CjO8RsJuEZmOqH0CjNuJUgK2NiL2JjB8gBqciMb0JwL',
    'Chandrapur':
        'BBhBg7zQ0mi0BH9FvQvC3F1GjGmH7M6BnP5JvKkHjHlHrM8FlD0IzRSgCyKtV5B5CyMyO6ZkFpGmIuFkFlIkG2HOzK4J6C6J0tB1I+HkW8UuVwJrGvOgCrO8M1FoG5ewIpDIlVkH5G',
    'Dewahi Gonahi':
        'BBRs4uQimh0B5DjPvHtDnGmGvHhFhHiIgC8FzIP7QoNnB7E7CoKsR1G2NwDb0IiQzCFlIkK9B',
    'Durga Bhagawati': 'BBIq2sQ8vi0BpJ7T9K8C9BkKxN7CjEoG0UqKuF8K',
    'Gadhimai': 'BBMonvQ+8j0BRvJtSlMoBtRnGlChPsICpHhOnB3H4KX+OiLkJ0ZmJ',
    'Garuda':
        'BBP0nvQo/i0ByBlFnHpCalOvJ5BgKzUh2B+JsD0OiJayGwPiPrIoGmCTqSoKuC/C3G',
    'Gaur': 'BBJgwrQush0BvTtM3J4F9ByQkJ0CiD6L8F4BS5ImK5B',
    'Gujara':
        'BBYu7zQo/h0B3FjWpnBlKxPvJzKzPjXwOvRjE/IuN0EoCxCsF3MAjPmOqV8csTB/BxK0RRmDzIsM7FkHmHwKjH+HmJmUlB0FnHoG4G',
    'Ishanath':
        'BBO8msQsog0BjOrDiDzMrE5E7L+BtDqI9MqCvHmJducmO5F5BzEyHvBiB/FqM+C',
    'Katahariya':
        'BBU2rwQywg0BzGb7KsK5JtLzHM3ByJvK1K7JuBxFmEyNwP5FsKjK+BO8I4OPiB9FmLuD4R9PwMG6CxFzEnC',
    'Madhav Narayan':
        'BBQ65tQ43h0BYnHxMvCnR0HjBsWvL0KkS6jBuUvD/M5JY9O4H3K8IItBlHhJZrDzOgNqB',
    'Maulapur':
        'BBOu6uQqtg0BfzFjJ6CtH5KqI7P/IyCrClHnFwJlK1E1TkRoSkH6DmToD9FoLkE',
    'Paroha': 'BBMkitQujh0BjHrSvFZmC9S7b9EhD0MkPkC3F0OkKqR/BmHgLoNkH5C',
    'Phatuwa Bijayapur':
        'BBWwoxQ8sg0B2LhHhGzFhaiC/J7KQqIpG8CjC7O3FkN3FzJ9G0C9QzOnCuFhMNxHwPuH6KuJ1CgL2QmHjKoO2L8KrKgY0E',
    'Rajdevi': 'BBNg1rQymi0BkEhDxD7I/MEnJiMrF7NjJzCtFua6JuEkCmLqHpDiBhK0H2G',
    'Rajpur': 'BBLgrsQ4qh0B7I/U+BjL/PkMpM9ChBgGxHwB6Q0OrCoP6KvDgH2E',
    'Yamunamai': 'BBNu+sQ8/h0BxOlJjC5IrOwM/G1ExF+D8FiRyH5B6B/J+K7CkFsF7BuJ8JsC',
  },
  'Rolpa': {
    'Gangadev':
        'BBPwltRg5pyBhpBpPnIjOnL4BrFtQ3bwP1C2VxG+FyP+LuLVCuMiRxGU4K+jB2JwS3J',
    'Lungri':
        'BBPojpR4sxyBuS7Jn/BrnBM4RhImOle8KwHoPgK/EoL8UyOjB2JgW8MgC8L2KqLhf9L1S',
    'Madi':
        'BBS+4rRikryBwG5HlUrIN1KlRwGBtMtLWlSxNhJgdhDstB67BugB3E9N9ENuJtD9FjSlN7JuE9EiZgI',
    'Paribartan':
        'BBTi2tRygsyBB3ZvIXzLxSvSgK5N9CxIsJnDwShchH2R6ftJ0DuK2NzI0WiB+WmJvF6EvN4PtJiQ8P8R96B',
    'Rolpa':
        'BBbgsrR4jtyBjH/IxOd7Z9OzV9S7EsVlNsG3DmN1MhDtF/UzF4BtRqpBoGkPkC/GsIiJuDsY2MwJc4P6GnLpBjT6PnFgdqXyF5CoboJgN9HxGpWUtb',
    'Runtigadhi':
        'BBY++nRwosyBjEvZ1IwG9SxH+W9qBrK5F7F/MrgBnGrMoZ9CqazIqDkMkMnL+V2CqL/MoGxN4UiQsEyN9LmY8a+R7JmJiCqB/L2GHoJld',
    'Sunchhahari':
        'BBUwmsRmzyyBp1BxnBgjBr0B7D/KvHpDzM8HpT7E32B8Q3BkRqlB+U3XmQ2L0UpLqfyGiKkZ2MPqJwXrH2CjR2TlBsLvR',
    'Sunil Smriti':
        'BBe28pR4vvyB+K9ClGnFxF6C/cpX5PoFqBkT5GoLb3P1MvJnCvV9HlLvDuG7DvMhKrE/TmK6G0QoBmPpEkBiQ0HxCgXlR2PpB6R0F+HyYnEuF5FiIlOP3R6Y0QuDzP',
    'Thabang':
        'BBTgltR49vyB5KnU6BpIiF6CoC3EpTpSqBzKrH7LtLrD1amd8F0YoL6MrjB42BsXiPgI6LoW8JJ1W+Nra+C3X',
    'Tribeni':
        'BBSwlqRynpyBAlG1NrC5GhKpNG3C8HpmBoXtb25B+SyHgJjGoJwuBoQOEzKsN1GwDzUyKwHwG7hCkOrL',
  },
  'Rukum East': {
    'Bhoome':
        'BBdg3vRspuyBRrF7NnD7BjMtJuLrWvFqBvQrOzGoGxjBlHpDnU4J1UumCuT0SpC0EhF5C5BqI8KqVpNyJ9C4X7NkaAyxBmXxVkX95BsXjdhEtLgKlC2ExLmJxDqEhT',
    'Putha Uttanganga':
        'BBoByyyRmwwyBnY3iBhI5VrmB6T1J3GhB1PlLxK3QyE3EuTlJyD1EyL/JmCiEuLrXkdZoL3IiHjOgfSuTqH8LiZwExPkhB6RqH8GvOkKhGoZuRgLxQ6KG8FiH2J3FwI9W6PlHjElUvMvGyHvR3NhJqCpTqLqBmKvRwPUuHyK',
    'Sisne':
        'BBtB0wzRw1uyBgJvJDlI9YpS9K4D1ZjkBhPyCTkW/QuCrDmG5MOhDxJvJV/Phc6OnhBpFlHzLxChIiOrE4TgE6EtFjB/EgJuB0MzQElF3HsCnJ1G9D/GybsO0GsBgUkH7DyM8FuJtL8BkMoOwDuBsLqHqC8D4JjCwHiKmI8mB3TiI6VwY4iB6ZzO6L5c',
  },
  'Rukum West': {
    'Aathabisakot':
        'BBqBml2R0+syBE1TzXlYhM4B5FpHvQ+BlK1GvG/PoD5J5NtP7FhTnf1apExnBnO5GpWwDhP/G2HsK9DgKgJgK7DsMwIuPPkS6K2F8FuTsJyD2BhG8D2GtUyQxC25BuPpC2ZkkB+K3D4QkK+J2LtK0P0H6NwKwCoEvFyMwFwFnI6c1MJhQ',
    'Banphikot':
        'BBTmhyRkqqyBxBzH1BiGrJxD7FtT5K1Fnb0KpO/KtFoMtHsB8RyR2BoVvS0sB8MmP4CwM8JiBiDyJmhBhJkBjqC',
    'Chaurjahari':
        'BBO+rwR8kmyBxJvQsEvHplBvH7S82BwCsU/KydsQ+BwBpL4PrLtBrEsJiFoTna3C1E',
    'Musikot':
        'BBXk/vR4lryBGhb/ShSiE5RxUnPnCucxFLD4H7JoG5FlDqBubrPwNxBqI+SkcnByNgVgD9B9LmFrJsFsBvB9SgK9T6L2CiD2G',
    'Sanibheri':
        'BBZ0lxRompyB1DvWhGtF8DrM/I/J+DhKlOlLuMrTlNlJzLiZ4C2EnToarJhFuBsEhJqCjIsZ6P8FOsG0JuF9CqSuHrBqFlMuR8K+R3KwD2D',
    'Tribeni': 'BBNy7uRwhpyBnErSnRdhIkO9WqF0DoLhJwlB8L2T6KSuMpLR7cyFoDkKpG',
  },
  'Rupandehi': {
    'Butwal':
        'BBUo+9Q+38yBjPa9L1IlP2EpQ7P4CkfhJxGnByM/HZrI6HySyLoNPkE8Z7D2F4S0BgVzJzFtHyBpUyJ7G7CtQ',
    'Devdaha':
        'BBY0w9Qi++yB9C3JjRsJtMpFxKyMF8IjPmM5EtEjWoF3HvD8BtH5SrD/FyDnCsP2NnBrF4S4D0EwK4BsBvJuY9E2f4jB8R+BjDjHkK5L',
    'Gaidahawa':
        'BBWki8Qgv7yB1BhQhXsB/DsGsMnbnKkGYxM9SnD8C9HmUgCbxIziBzQtX2OqM0LlJmEsKsF7E+dgM2BlEsJwd3BwP+HmEjH',
    'Kanchan':
        'BBTs78Q2k6yBIzTjdnEtT2FtC8KtQxD7C8H+SqDXyMoKjG9LwbuDxG6R9CyFmFqRjMyD9F/H1J1HJqBjF',
    'Kotahimai':
        'BBRg94Qo07yBvCtI5RlI3E/IhNgDyB4UlRwHgIoNRgSwQrGuEsJsLiCsKxM3I5F9GpXgIQmE4M',
    'Lumbini Sanskritik':
        'BCXo85Q476yB2CnVrKrFmJlE5IrLhNmC/Q/H3GqFpPxGxIgJhI7I5OiZ2GmTgNb6B0HiN/CwS+PqKrFqHgMyFhIoE0CY5HwHgBE7S7ZH4JhbbI3J',
    'Marchawari':
        'BBQ2x3Q498yB/GzevJkE9HpJ9E5WlMrElIsDxD9IhDoQwEI5CoMwGwN4Q4J2DqIiJ/B8NuP',
    'Mayadevi':
        'BBeys6Qo17yB8CzDxNjC0D9J/QxCzC4InEzCxFiIpH/LlGDmCgU1G0IrE1M/HP+GqX4I6FhDwP2IrJ0HoDuLwP9G0H0JmNoEInB5WhKlasSkGVxHuH/D1HtCXxG',
    'Om Satiya':
        'BBV6t6Q2k+yB3EhG5JkBpE7J5H2R0IyJrB8FpSrQpH8G6CqRoGjB0JwTzB0KsGN1E2PmNyMsHtZzNsBG3ImJtKiBpb',
    'Rohini': 'BBN015QkigzByC3GrGO0BzKzJvTnGkBmBzNlGnMrKiK1Dk0C0MtCuHhLqQO',
    'Sainamaina':
        'BBWyn+Q8m7yBwDvGvH/X8GxFvKtLgInHrCvI3oB2IiCkVnQzFxJkEuQ0MhWiSkD+LpEQwIqWoNsPmP1E+L2IkPnE7H1J8SxW',
    'Sammarimai':
        'BBRw43Qgu7yBxBlW3PxB5FxSzGuJpLjE9HsEtKyM8CmImIrDmMsE+E6WgJ6JsEBWnKwH3GoH4B',
    'Siddharthanagar':
        'BBM275Q8z+yBrIxL2BzKzJ/J2GlJhT3S1IsJjC8tBoMnKImEwJhB2LmP',
    'Siyari':
        'BBX8w7Qs88yBnRnW/IjBlI7QhQgMYyG2HuCtHgEWyHvS5FoGoG8DwhB6ETwH0MwNtC5F/HqC3GhL3B+CpD2I5GwQwF6DlI4HqC',
    'Suddhodhan':
        'BBUkn8Qsh8yBzKjUjK2BvD4G1P9H3QsGmI8QiPwG+GmQN1F6EgDrGmM3HpC5DmIkM8F+I3HgIaoBxMiJyGrFrc',
    'Tilottama':
        'BBSss8Q26+yBZzenNQrWjPpZ7H1LkKiL4BpC4G6FgIzM8QjBmf2F/EsJsDa6I+LuEwQlGmGqEkPlM',
  },
  'Salyan': {
    'Bagachour':
        'BBW0rtRu/oyB1CvSnL1RgG5Q5axkBnQmBlSwY1ExJrFoDlEyLoG0FXgL2CiGgFzFuDyD9DuTiEuQoL3BoIkO0pB2N0EvKzFvF',
    'Banagad Kupinde':
        'BBnB8pvR4ziyBgFuB/E1HwCzJ3Q/BLtNhL2E/P7K3gB+UxetKtE9MnJ3CKrP9NOvSuRzM7IrVoSMwMkH2C0E0SkQmC0PiQ9EiI2FuIvC+JqIpFqCqIqI9H2EqFwEtSiLwIsQH+S4SgLL6DnMuIY2ElI0dzBdpR',
    'Chhatreshwori':
        'BBe4orRy5nyBrD1DpFuFzB7QnGzFgD3G7M/D5QpW3H2D7IlFsK1I3HrSnM7DtI6JxJ3BtCsckFoKyIrI6LyF3H0PiNkVDwItQ4O2IxCsEgN8aiM2JvMoJoByE3HuInB',
    'Darma': 'BBL8wuRqunyBPvOrJ3EzVrJrbG4FgUgI2EhG4QySklBgStJmKxQ',
    'Dhorchaur':
        'BBSw4sRy6kyByN/Q/NnG1GtK/OgBlNpIpCkW8JqHlLySnJ4E0C8N/G4BmF4SjI4KuFkMmSvYkR9BQne',
    'Kalimati':
        'BBnBgxqRqy9xB5EhR3rB9OpMya/MiE2FqJ5G8V7NoNhHlCkDyNtKwWoDkMyJqJ8NhNkI0K3Q4M2BiJvJzFXtHhM4FpN6fmZ2S9CyJ4NkUrDuRgQ4NuP/E0K6DjC9JsFKgFpMyGQnGvLsBxayKrNnHzDXvN8NzO5Pzf',
    'Kapurkot':
        'BBWmqpRw3oyB5B/MnFrCvDmFtE7EwH5EtGnKtL+ErHrRhTtJbwK/NqHG0PhVuSLiQ3MwCsgBoG8FgNsKiG4JjVihBjR4C7H',
    'Kumakh Malika':
        'BBQ2gvR2rkyB1CzVjJtCnT2E1EmInIf/DwM5LAza8aKkmB6U2HyS7CuegOiH1jByJ7L9GrW',
    'Sharada':
        'BBiBu7rR8vkyBcrFzGoDrHnP1GgIjErIjI2FqCpK1FtIiF5H3PpQrPvB1FrL1JmHtB4aqGqLzGJ/EqMrFJwCsJvE+BuDoU0L0C4HsSvKmHmEuFyMtC6QqWiNqE2NnVnFzSkHpCzC7NoJ3E',
    'Tribeni':
        'BBXstpR40nyB5M9V8HvP9L1FxIsItFjL4CvbyP/BqD3U1JtJ9P+E/P3NpKuJgJgQrFqSmE+LpHsQ2FiZiTuJsHsRqL9EyGoK6KlH',
  },
  'Sankhuwasabha': {
    'Bhotkhola':
        'BBvBwlgR6ru1BmC5L7NtKmCpchPlZqH7coFyRyMlI3K/b9KjKpB7YiL7I2E/alHzNpMhItBhhBrUokBnC6XviBuXnSnN3PwFvZumBCiP8J4R4QsLiJwT4BykBzQzBvH8LyEmI2YsK1D8HzKoDqD4GvEmJwXsKjB+KiNkBiMiOkHjE0R0MqM9H8PiDJhV9OlPmG3NoU/B',
    'Chainapur':
        'BBVu41Qw7s1B6a/V0V5ItKvH3Qzf5TxPxQ1uBL9jBpGpJjRF3B1H/KuD3VoWkSsRwIuYyU2cwH2ZgC8YjT6mBsRkOoJ/L',
    'Chichila': 'BBNg15Qi3n1B/GxVlQrE3ExP7M5L9Bmb/H2GuB0PnH2IuGubgSoJ2VJpDxZ',
    'Dharmadevi':
        'BBR8p0Qs5p1B2H3IvQvjBhSnRpMuFhJ6IoIkP9E+Q4DihBxF4GzHlBpTqUoMNyM2IoC8TsLwLiF1X',
    'Khandabari':
        'BBN0q4Qwqm1BnQjU7TpBnfgqB3WpGrI6L9T0DuZgEiNrHiS8Y8RjE8LqOyTrC',
    'Madi': 'BBJqn1Qy1r1BnH1tBvOlV7WigB7CsQlMiSzC8V6KE4gByQ',
    'Makalu':
        'BBzBo/hRuyj1B7C9VvSrBlIvInmBwOnM3I/G8UzO7Q1ZzC5MiMzDwY7J4M1bkXlVgJpXsdpIerP+RrKhNtK6BjF0PoJwY3NuOgEkdzH8G+GslDgWqH8MrD8TsT5CkKwXyDyDsGoInDqIvQ0Q0BlErrB7gBpoBNxQmGpDgC3N6XtYuJrCiSmNwiBtXoC5XygBj4BkC1P0VtFoF5LmUnG8GxP8O9I',
    'Panchakhapan':
        'BBMuj3Qspp1BsIlKhXxUrXhkBxa0DkGmJM+jByQ2uB6TyP4Q0fiKyG9InsB',
    'Sabhapokhari':
        'BBPik5Qkqp1BwG5J1VKvQxHzF/TnU6C7LpO1QmD6KySiT8PrImK7DkmB+IosBuIsG44BuK',
    'Silichong':
        'BBe4w9Qo4j1BBlMpY/MvZpCzZzSxUJ5G6HtMQvI1L3LlD/PwMnPnOtO4rBuHgUrEoJ8LuJ3C8NiF8IhK+TwRgJiNqYwKDkFzPsHjCuNsNsP9R+KxD2U3amV/I2bjX',
  },
  'Saptari': {
    'Agnisair Krishna Sabaran':
        'BBQq1pQ07/0BiC3RvQndqInHtU0KjT3D/hBuEuE4T/H2GoByK8WuCmM2MgS/BoHjJgGmHmClI',
    'Balan-Bihul': 'BBG+5nQm350BpoBxRnJ8kB2N4D+JjIqZtB',
    'Belhi Chapena':
        'BBNs4mQ4q90BoCtFlF1D9J+BoDhOxZjFjK9MlNrFlLsqB+UwIsHhM4W3D4GkN',
    'Bishnupur': 'BBMm4mQm/90BftRrNvB3C5K9c4HzDiTmRsFjIsO6IuCqN1I7IpVqVgP',
    'BodeBarsain':
        'BBPk6nQkn70BhGjLoCjWpWI9JkI1N3DnVmMhE0IyOGoD4K6HwC4UjCSuHkO1F8IoE',
    'Chhinnamasta':
        'BBN41lQ0m+0B+B/ElRrFiC3L/HIlFnH9P4BzB4M5HgG2D2KqEzB2K8M6V1C',
    'Dakneshwori':
        'BBOilnQ6h90BgBlN7XjM8C9K4LrCoCxPrWkB5HvCnD3KhNnC1MokBqR8OyZkFlDkO',
    'Hanumannagar Kankalini':
        'BBV+knQ6lh1BhL/ZnelFd5H/H9C7F+NrFdxJlP8E/EzBnN9K7J5JohB0LmR2CwUkPpByJsPiU2KsNwY9D1TqOrCNxV',
    'Kanchanrup':
        'BBWs3pQu7/0BxP3ClCmI/FlHnHkJzS4BpQ8Q+DoEtJ8LpQwCHoXvOgD0MmdqWrrBoWiS8W0BmBtiBqGzK4O1EpHhDpG5O8L1C',
    'Khadak':
        'BBR6tpQ0u70BBpHvS9TxQb1SzJ9DkTmEuS/UYtJyO2LiIoHzCc8E6RpH6dsP+MGsEnO9FtO',
    'Mahadewa': 'BBIwonQ+m/0BhHnI7b6F3GigBqRwGqJrC8J/SnBxK',
    'Rajbiraj':
        'BBP4pnQ0k/0BItOrJpFwE/HrK/OzIyJpV/O8IqV7N6ItNxEhDyQ0FwPyOWZ5G6d5I',
    'Rupani':
        'BBQ82pQuj+0B1CvH3TsLxX7E1CtPjLOYxIvTBnJvJ3I+OiCkL2I8BiE0LvEgIgnBzEkT4D',
    'Saptakoshi': 'BBNmoqQy9h1BsQ1GhE/ItMqBhRlQG9I3O2EpK8TgHsF/DwTjFSsb4UsOtK',
    'Shambhunath':
        'BBTy1pQu790B3BpM3LhNmKxMzGxErOZ5drPzRqHhB7EnH0CvUjIpBuOsWwII+UwVqBbuIoLJ2CuPyX8E',
    'Surunga':
        'BBSunrQy260BzCpYvPnD9JoFnNnQ1P4EvZpHjaoHrB6PzLiCitByM8SmU2P5L4KkBkE/MwSiPuFOlChH',
    'Tilathi Koiladi':
        'BBOujmQqn/0B/IYiB2GxOVzFvPsDnOzRmC7CiLyLsM7D4PwL2Q0ItO2I8C8CoI',
    'Tirahut': 'BBKggoQ2pg1B4FjFxLtMnY/CvIyTtGyCuKmEwJ2a4P/KnB1J',
  },
  'Sarlahi': {
    'Bagmati':
        'BBTmmyQi7l0BsFlE5JZ9ezhB5NLzUzTpHoSvH0B1BgJ+PuB3J8QyN6F3CqH0J0GL6GsbqEsB7H0G0JwTuB',
    'Balara':
        'BBTm9rQ8qk0ByFrCzJ9RDlVqH9L7PpH1KiMhGlHhBiKxIuDbpL5JtE9BoFwN+Q5C+F8NwSoFsDgLpGbuP',
    'Barahathawa':
        'BBYyhwQ46l0BiCpFxN5F4J7Q/PxByQ3c/PnKxOsJrSnBtTshB0GuHpEiH4IoF/HkLiJgEmH3F2S2JsJiMqCtG3JlEoC7DoIsE3G3HmCxJ',
    'Basbariya': 'BBLksuQkmk0BIxIxUnHhFsasD4PhL+SkNxDGsJ2H6CwFhFzJ/W',
    'Bishnu': 'BBKuysQmwl0B3KxL1QDdxJ9O9F1EuL6GgPmGsBpDgKwUmF',
    'Brahmapuri': 'BBJ2+tQy8o0BlVxe0K1FVlL9nByF+NqVgUkKhB4LuKqD',
    'Chakraghatta': 'BBJm+tQugm0B/FzQhZ4BxDyW8IkEEqLkQgBgFzJzFhI',
    'Chandranagar': 'BBL+3uQuuo0B8DlCzHhJgBnKsGvFtHjNziBhB+CqS9KuGsLmUmQqD',
    'Dhanakaul': 'BBJm1tQgnk0B0C1QhXkDvPle7FiSmHiK0FijBmVkKsHrC',
    'Godaita': 'BBOo4sQ2ul0B6S2EgF1PvTjG9ErM9QjIxR6F/B5RlKiC5B8V+O+FeyJ2QE+G8J',
    'Haripur':
        'BBVoqwQ2wm0BoJzFrJbM5G7KrH3V7ElCyJ4G4HnIrEnC8D2JqEnCqGzG/EvG6OxGnFrD0PwE4J4K2KoP3G6SyEtDha',
    'Haripurwa': 'BBMivuQ2hq0BvDpNlDwE1PxJoL5IlGnIrRLvR4NI6HgUiN8JxCsUqL',
    'Hariwan':
        'BBQqlyQ83m0BmB3F/Y7BrGxJzB6HnQ1E/QqKNmZoIrHsJgCiN8nB2S+BqJsH4F9DWplBpE/F',
    'Ishworpur':
        'BBV0vyQ6hs0BpK9TnKaxpBrZ9iB55C/KJ/H3HtH0PuH6KvW0HjKxDgJsUnLgJ2PyJqDrEwCsWsyBsN0X4U0MwDqB8Gga7C',
    'Kabilashi':
        'BBP+jvQ0um0B9BjI1S1JlH4F5PvBzDwX7MrCfgWkNwBlB9IsIqEkFvFiUmDsDzP2GkF',
    'Kaudena': 'BBIyjtQw3m0BcnL7IjE+CrXrH/DpWmTrKzC8B4F',
    'Lalbandi':
        'BBT+hzQuwq0BiDnH3F5PtbxjBpHgD3cvMpKrkBrJ/BnIsH6B2LtW1CqG2e2RmdiK4iB8IgJwemLwC0FmKb+J2S',
    'Malangawa': 'BBKoqtQgjn0BtC5M5KG1kBpTpB4GgPwOxCwG2Q2NtBwEkTnF',
    'Parsa': 'BBImutQs0o0B3UrM2BuJ7L+EnG2XoNvC6EyEsLhJ',
    'Ramnagar': 'BBKizsQiqk0BLlSpHxK8FhSvJkGtH9LnH8LYyX+I0PgQ8G',
  },
  'Sindhuli': {
    'Dudhouli':
        'BBiBs8xQo600B9CjQ/NnBnJ/Q5SyG/GpRkKxMStO4HtF0DxcsMlI3EtM5JKerGlHlChTqTnF9N9GhDd2e5V+2BnfsqBpI2C4S8O+I2TW4X6pBwS6D3JqKpCwH3K+UqKqErNzEpLiHrNgHtB',
    'Ghyanglekha':
        'BBZ2r3Q2sq0B1CnJnN1IhNnDrIuG9KzNrKiE8JsQnIiDtGof9GgFhDuNqHiEzByLpOgIL6GsCiPyMgIyPvH7BkTkP9SyEjLjEvM4ItByM9T',
    'Golanjor':
        'BBZq+1Quyv0B7PjXzHoRZjI5S9KzGyU3HqEzK/FsCiOzJ8YhKyJpD8O9G6B8K8bnKwOgTyR4EiM0R1OE7OnG5E2SzW7C9K6EjL8J9B7BpM',
    'Hariharpurgaghi':
        'BBkBw12Q82l0B/CtKvMxPzIfvClNlHtEjX+L/Jkb7d2EagK/O6DWnNnHkC1DrHjG6FiBuIvGEjF5I7GmH/B+QqFqFrHyVqEgGPunBqN1DoM6H+QnMsP0HzC3MqFlNmhCzBjD9Y6KjQ9D5LqEzGmF+D',
    'Kamalamai':
        'BBqBo41Q4qt0B5ChEjNsI3MhIpChVsOnIpClQ7R5EjGuGhO9HhWuIvUnH5Eoe/ItDtM6QgM6MvPqiBtS8DzHmLjhB8Q9E0mB8G+CoF+N0P5Q8QnH+BhQgJ8KsXtUsV8RgDkWwI8JgVpoBtBhS0KgG4HpE0GxU6S+KWiIwDhD6FlVvDzGqJhN',
    'Marin':
        'BBYol2Qq0o0BlDhZ5PtBlU+F/IxE3WmDAuYrPzH9QoMnM5HpN2DyZ+fgH+R9NivBoSsD+VtIiO+HkGtG4O6EuQ1xBoIhD9JnQ0RpGjHvS',
    'Phikkal':
        'BBUut0Q8800BhOjXmJ5exOgPxV5D1C+K1N7HnFgX3M6J1F9BzCuWzKiKWyMkXgLhE4PyY2NqI3GgGjWqQzB+F5c',
    'Sunkoshi':
        'BBQyj4Qios0BtGlN+C1Hnc5KpV6lBjJ8BgC0S7a+qB+B2NyOkQyVzD2IlHgDrGvFvG8RjRgKhpB',
    'Tinpatan':
        'BBeyyzQozz0BJ3J/SxRoKvOhB7LvHhBpC9OgI5GvI7J/CjWrV7RrXuUrIrL9Jud2JJiF8MrMmIzDyc3HuFRuO9J6K6GiTuTrGqC2KqUsHyHiMoR/O2B9R2N8H6C/K',
  },
  'Sindhupalchok': {
    'Bahrabise':
        'BBWyohRiss0BzOrGnIyI/JvBzB0IjcvLjjB0SiC8NgJsImB0rBiHiLpFwckQzD2MnL/B7erH5GdnP0J0CqK/RqMEgN1VuP9E',
    'Balephi': 'BBKy3/Qwwr0BvCjJjdnGjiBkL8S+8BrBrNigBjQlGjIsDpTmR6J',
    'Bhotekoshi':
        'BBX66jR4gu0ByCtI9ErG1FiEzMtMlFuEjchMnMY1PhX7E0MtP+E/M2VpMDpKgS1JtCgC0RsGoE8Bsf6rBgnByJhgBpClIyStgB4iB4R',
    'Chautara Sangachowkgadhi':
        'BBNw0/Qsmq0B2O1UniBpKvkB+FzY/E5nB8VmJN4DkM6K8D2a0d4HgB4hBnLiYmF',
    'Helambu':
        'BBaq+lRmum0BnD1OtIjIxUVRnK9NrTrQ8WrQ2LvXlG9M+C5HrIzVyFlU9GjXuEiO8yB0uByfyFtB5B3O0WpNwOyBoLjGkL4F6G9G2F2F6clC2N7E',
    'Indrawoti':
        'BBP69/Q2sp0BoLkH1FzNxFeZxM5Ppd5LsH1DpXjJ5Bnf4YnI8ZnJmK0YgFwkB9FkNsG',
    'Jugal':
        'BBwB04mRojs0B9BpK3NnNFnlBpH5DtDrTlHA3YqUxKzIrKcnc8RvX6DzL7LlF+HzEjF3MmDlQvOpSZrDlH7IFzNgNxEyNnC6WsHuFAyM5ShItD0SoG6I2e2J0BzIgKwBkLhI6TsM+HkQoMXkciMmFtE0MuMgFlE0FwGgNlDsJsE+M1D0IhR+MkBmO7M0K3BSnM',
    'Lisankhu Pakhar':
        'BBQ8y9Qmtt0BiJtIpJzJ9SzBtHtTjLnFrI6FnH5CnLwP6BwPxL0K0Q0QyQ4E6DmNoW5B4BnW',
    'Melamchi':
        'BBUgrgR+9n0BwQrMtQvUtJ/pByVpE1Y5PvUzB3YoP0I6lBjRiU9FdoB5I7EyC7Cmb0C4D+UzS4IWuEgY6KtIkR4e',
    'Panchpokhari Thangpal':
        'BBkBglmRs9m0BLrLpG5D3J2S1N8E5cmC1F1F5G+GjL3FnLkGvOxBzWqN6B4OxFuB7YzS9JpBra4ZpD6byFdqNkWqSamQwO4MlD0EkFmF9H8I0LoaxDoc7RsKbyK0IoHtJmZpL3DxS/NpPgS/P7C/K',
    'Sunkoshi': 'BBKmj+Qs6s0BE7NvNngBrHbzdld1D0yBkLoF4H2T0SsB4I+J',
    'Tripurasundari':
        'BBO22+Quyv0BuD/IhHhLlBzrBpQxThc4Y3BoWiXsPnEkKmGkR7BiQgJsC8J9IiH0D',
  },
  'Siraha': {
    'Arnama': 'BBL2rqQu410B1DvP1PpJzuBvGtCyGsIe2JwP6SgDDgHsM4EyThC',
    'Aurahi': 'BBKglpQkv20BJ5GvOxEnClG+EIuEzNzP/Q9SrGwCupBoJ6H',
    'Bariyarpatti':
        'BBP28oQmh30BrFpO8D0BHhJtUrBnJ5H5BmL1GtCjIkjB2DhE4KyEgIsLnCrRgMiE6DjO',
    'Bhagawanpur': 'BBH+9nQ2l50B3GlJyB1IzY/QvO6iBibmMmOrE',
    'Bishnupur': 'BBH6uqQos00BPpG1S1M5CiVvHwG2ByIsVsQ',
    'Dhangadhimai':
        'BBZ0xtQoz30BQvN3M3F+B4JnGqFthBoFvLxQjIoC+ExNnHxGlcvItMiIzL4pBsRqKyF/JsV6CgFkDvB4KuH8C7C4E2kByOuFwIuG/I+KHDrQ',
    'Golbazar':
        'BBZuntQio30BhChIhKpFwEnP9Q1FxY/lBvHkEqH4GgBiO5PpIxCsFpa5HrD2GoFqBL8GxTiCuIyC8G0N0G1FkbqIwH4G9EyNkInCwLyQuhBnF',
    'Kalyanpur':
        'BBTw2rQikz0BN3Ova/C5LyH/BkJngB8NMoUmHoHiD9O+E2DtB7H2S2MMiKiTyIuL1ZnErEkH9FxP3K6G1F',
    'Karjanha': 'BBMu1tQu6y0BgN1DhQtOrcgF9LyJ/TxBIsSsXwLhGgF6CqKnF6K4QgD',
    'Lahan':
        'BBYoysQwr50B3DjJ1kBxO4C/EnJrIuD/E9HxEtSrBnFgKzQlI5C6E7OQqBwQjMpDhH0MgB2Rwa0G+PzEgNkQgWpD+V+S6MhBtCjUqHlB',
    'Laxmipur Patari':
        'BBOq2pQ2130BuDvDhIoBxK1MhV1IzEqOzM3D7BwEyEuN2KMoKkXsNqBxCtPwQ7B',
    'Mirchaiya':
        'BBRojtQyt10B/KrblT/EsF1K5CpKiG/ElXvL9S/BtDyF+PqJjH+FoEsE9JiV4CoHoRmFyfirBoJP',
    'Naraha': 'BBHo2rQ0310BD/M7GlJxgBtRnE+dqa6HyCrF',
    'Nawarajpur': 'BBK2roQq340BcpEhP5HmH5MrJxPzT/BxHgW0YgRxB2IiHmJ',
    'Sakhuwa Nankarkatti':
        'BBM83oQo040B1JpZ1KLjGmQmPoIrByI1FjBnLiMU+G1NoFsSqDqSjF',
    'Siraha':
        'BBU20pQ2w00BkErC1L1LgC/T1TyC5J9QhIxCfrJtH2C1KvF4Dyc1MkC3DyNwB2KoQ6KXyFwM8GwCxGmMRwbmG',
    'Sukhipur':
        'BBO2nqQiv20B7GzN5UpHdxHjMzDhG8O9EH+RsNvO2HwE0RoLwC0K4M0HvBiHhf',
  },
  'Solukhumbu': {
    'Khumbu Pasanglhamu':
        'BB9BmhlRug70BnChLxJ6C3IjFxFmErLnKLpIte7M7jBiDvIuRhOqE3fLtazI5G4QvV9BrJuFc+Qld0S/BiYzQqHhL8PpcnGvK0EjEwKyE2G3ImCzDlI/EyPybyJvIqRgMkLmzBmJgP4I6G+TyL4CsHgNsHrB2CqG4pBnKkM2Q9CoJmHse2R5DmIwIwSsBmIjf6PjF2FjW2RhOwBzJ1HjKoCxc+LvKB3M8H5DiPqLmSzQiD3e1X9hBoDxQkPvC',
    'Likhu Pike':
        'BBO2s7Q6k50BpEjf1OrN1LlXja9MtGqMWsQvSwNhBqKiJ3C6DwL+cuc6KxDoM8K',
    'Mahakulung':
        'BBnBitgRy5i1BpB3qBjM1Q3pBoK1CpGrHsBrH/M/KlClDvQ1MhKlzBjJ9OnN/IgKnP0B9M5H5TD7Q8GwGgOjH4KpD3I/f0M/CgMqImlBgV4KoFqJgQvM4LmDwI2LuMP6G5HmUGga4SwZqCqYgNmPpS2Z0C0O8QgH7U2L4I',
    'Mapya Dudhkoshi':
        'BBVin7Q03+0BiFtGvXlEhEjGoFzO0DmI4IlCtElFyCvK+LjGlR/LhOa7D3dn5B/NrG0foUkVxKiUsduV6a4GmKoJqO+C',
    'Necha Salyan': 'BBKop3Qki70BrLvdtOiSvPgETg2B0IsN4HC0DtQ4UtSzE/M',
    'Solu Dudhkunda':
        'BBegk+Q6r70BvE9VtetOlTnB9iBpcvPqLnM7K/OiBpZzanD5KzciMxFiI1K3BtEwFoDoR1XyV6L+anG2OqEmSgQvN4lBzBsXuMoU4B8D4diOZiSwM8a4F0L7PuSpJGhW',
    'Sotang':
        'BBP+94Qgu/0BqWrH2OWkLuH+PpBmG3KzzB9S3SlRvY5CiH8VzQuTnBgjBkflKqD4IkH3K',
    'Thulung Dudhkoshi':
        'BBS+54Quv90BwDrK9T9TqFzchXxBVmFjR6FzS4PxEgOyR+FkB8pB8KuM1C8KiQmQkD3QyPzQhH7V8NtB',
  },
  'Sunsari': {
    'Baraha':
        'BBa2+sQ4vm1BtFtJvhBzG/lBhXvGzZuHnNpVjShN8dhGZpIuJhfha+E2PpEsJsLwEsJ+RkiB4YwG8LzFbvBkLwK8LiYgF2T8MwDvSgUqGyGrIyJD',
    'Barju':
        'BBSg9lQw4m1BhOxPjQqL5HnDjauKVyPlG4E+GsQ0YmBmKnFkKsEiHtHpIhIwBjJ2JsB/BpI8KvBxE1E',
    'Bhokraha': 'BBJm4oQmpl1BpJxPvN9FrgCkFR+K0JjBgFkQwJ9D+IsL',
    'Dewangunj': 'BBMm9lQmtm1BSzGnK1FjKjTnG0JpQMrGjNrUmeToUyfhM6HoDkQpL',
    'Dharan':
        'BBUq9sQ47n1BzHxMiBzL1ICtH2IjTzGvDwShhB9PhKgXzKqG4CmHhGiHgQwElIgd2RkF6VnJwU+PwQSwRlhBxFpZ',
    'Duhabi': 'BBNy9nQgvo1B1lBnoB9RmH5bjGvBkJqIiI5G4HsUiFuBhFwX2X8KyEqK1D2KuG',
    'Gadhi':
        'BBQqjoQ6no1BC9SpHgFhHxF1UxsBjclFnGgLnKZmKgK3F+DyE2E7KwBgCqIkS4E+RlHkdsgB',
    'Harinagara':
        'BBPowmQykm1B/FpO6FpMjGrHzJgBW3KxtBqHnIgLkENoDgNyQJoGzJuLwUuJkF+F5E',
    'Inaruwa':
        'BBQ0voQ+5l1BiIpHtKxHxmBwP5O7LzNyHwH8O0O2C6Mkf8O+SqH/E+CtPgMgEhBhStK3G+C5T',
    'Itahari':
        'BBT+iqQylp1BgEnNhQrDiGtI3Q/epK+E7M5IyB+EhG+CvD9J3GhClFsVmDoKnIO1EmakMuD+UpJyIiL0dmP',
    'Koshi': 'BBO+joQqtk1B8DxB1E7PrmB9a5OtRvGnSncnSaiQgR6ByJ0zB0W8Q8LuBXyTmbnB',
    'Ramdhuni':
        'BBV8pqQmtn1B+ExE1L9CrJnLwBjL0FcvG7LzelY/IG+EqG9NmK9C6TuK4GbiamG7CxB9E8M6IkKjFqFmR6IsH4KzG',
  },
  'Surkhet': {
    'Barahatal':
        'BBoB6myRi73xBoI3H9JtMsBlHrG3CiChPhKnLpDnU7GOOwOzI+LzI/I3KkG9HxToDvVzOrD7BpQrK5GjJmEtSy0B9L4OzRsI5DyRrbwnBimB8KwJtIgNqIsCySwJ2B2E/F2QkL0I3B6HiFsC+O6KtJqDnQ8W9RApQqJ2I6NtL',
    'Bheriganga':
        'BBVsmtR+j5xBmZjOhlBhKrJ8FG0L1xBm/B5CoS5U8b1EyV4MyHM6UgPgDmL6LiJ5FoE5ZySpWyGVkOpb7E9ImEnkBvGjV',
    'Birendranagar':
        'BBWoswRir6xB7DxYhQzCnQhLjF+FvJ1BrCxS/MpIvFiIxd2L7OiUwL8xB6Z7FmiBoG3Coe7IiK/EnDuRiMsE4MqU1uBsIrHoBzf',
    'Chaukune':
        'BBsBm71RonvxBgEnI1PhRsC7LlL/M5LkZ7a+SBgNtHMnBmKpLoIqE4OwI+B8E+I9R+I3I9C8CmNrLqSqFiC8ElHyRsCauExJwB9K6P1HzC1E8HlJlKjJqNjMBtMgI0bwrBiauF4EnFqHkIqakG0LjK0LvVxCxL7L7K6H3M3F1FqBnUsIjW+atgB',
    'Chingad':
        'BBRu/wRqj+xBhClFnbhEhvB/mBnSgK/BsHiI8I9E2EuFqGzZwT/FwToP6IqJnE4QkE4JmXuW1ZymBnU',
    'Gurbhakot':
        'BBS0rtRm3+xB5InOhtBtO5CwM1HuE5L9L7P7EtgBisCgJmYiHyHqO/CyFkIwStR2MyC2B3NiX5LwT3dyJrC',
    'Lekabeshi':
        'BBW+/uR8u7xBzDlJpf1DlWoH/H3GvE+N8E+IjOqbxGWxSqWlC6OitBuO6GyK4dlbtFpG+E1EhI7IgCrHqP1Fd7K6EiEyIxJ',
    'Panchapuri':
        'BBkBm00R+q2xBkDjHlPzmBjb/FpHjI3EoFhatFzbvrBhHrC5BmKpO1DzFmJ1NyCpGgd0JuN0JLnDwV+HyT4KjG0IgJ0I9LNvOgIsBmCuSiKoLhCiPsG4CrBmH+JuMnI4HOsI6KgEmLjPqM5E4HnR+YwB',
    'Simta':
        'BBW2uvR45hyBjFxoBqE9lBhT+T3JlX3QjEpJoEtOhJhKqGvT4dvYuOa4XgFxBmI2QuToJybvE2Q9OgQ8KmLxEF8MmQyB2BoI',
  },
  'Syangja': {
    'Aandhikhola':
        'BBQklnRi7kzBjOzOhE5Q9W+E3H3OpG4K3JAsG8dvE4M4C2T+JlLqBwI2HN+OjRvC1JiXuE',
    'Arjunchaupari':
        'BBRk5lRkyjzBvLhUxHpC1KuP/GvQ3FiQzNyL8FsFtD+C2GuWmK1CwHqIhB6HsOlD9E3iB4JA2BvJ',
    'Bhirkot':
        'BBT4xkRokjzB1CnGvLqC7H5LlLiLhHdA6ZtOuZuB+FyG9DIgdoL+Q8CzcsJGcxGqO9HvGnYuD9C7FrF',
    'Biruwa':
        'BBYgokR2knzBjJ5vBtC6EtEjFvJoNpHlHtakGvHvD7DoK9H/BtD8RnRPqckN0GrQ6GwGjEgGqNiOgCtE8IiEmEhH8MkGiE5DgGqJiJlE',
    'Chapakot':
        'BBd2qiRi4lzBqEzE3D/C1MuBwCzNtXqIiIvLpBpMsFhC/G5PgH3JpR6B1XwgB6CyI5FsPoIFhFoIoJ+LxMyd8E8KoLd7CgHoHiGgNzFyBnY9HlHoRQuD7R+HgC',
    'Galyang':
        'BBgB0ljRg0hzBKzGxGvCkE7N7JvB3FxL1M+O1pB8PwByN0P8M7G0E2EgEpCuSxM8O8EoB3CqIsU1EpF8KwD4FuKA+BnayE5GyIuGyClJnLkC1E3M0OtMuDqGgB7K4MsC5D3I0KnB',
    'Harinas':
        'BBX87jRuznzBrEtK7D8DnNlG5DkH7IhE/BuEpHtE/F1JgEnG7GlGtGsQzUhHb4YxO0FmHgL0d/GmJ+HuPF2N6gBoJxV+HjB7FzR',
    'Kaligandaki':
        'BBR4wiRsy+yB3ercgB4MpH0O0D4N0H4BrK0JsJqE7G8KqJkOxHyB3EgR4G4LsUnH8HzKzBxZ/HzR',
    'Phedikhola': 'BBJ8hnR8mlzBnE3GtVlDwC2JzW8V5C2oBgTLyOxQuCpa',
    'Putalibazar':
        'BBbi3lR0nnzBqDnEjJ6BV5FsGnlB/DtKxK6KerbxOsDehIvI7IxXoNhB2GvIhBe0UgFvEuJ6C0F0Y1DuDyHiOrC4auCyEkHnFgIyTqK6HgK5BkHzN',
    'Walling':
        'BBlB61jR84izB8FrEnOQ5IlTlKecsK7J9Df8KjDnGhEmG5D/C5GyNuEsIoLjCxCmJxItGxE6G2BwTzD4GtKAwDiKrFiChF0Z0ErGkR3DvBuP2CtF4MmFhEkN4c5FvH5bkDpKxHgDX3FuOtZA5ZiHe',
  },
  'Tanahun': {
    'Aanbu Khaireni':
        'BBW43hR23xzBtEnTzNtCgDyM7DgCvLjJ6D7H5VhPMuQ9J+HnJjE9BkThHnH1CqlBsKmEkC6UmOoC8KpLkS+C4HlEfpX0EmD',
    'Bandipur':
        'BBZo4iR05vzBvOEiClKtItF7HoKjSV/LlKjE8I5JjG9FwIY+NrQgZamLgN9F2CxR4SmQ5D8HsHoG+HiBN1NkLsD0B+K+F8BmD7Y6NjE',
    'Bhanu':
        'BBVirlRsuwzBrBrkB1NDjBtJ5StK7H8E1D6P9GK/CyNjOtT7G8I/GpB5EyK6GsBlJwWpRsJyQ8C4PsWqdwF0EmH8cnV',
    'Bhimad':
        'BBWoqjR+0pzBxFldnK1QtPGlJ9HziByE4PsW/G6cqHhByIqIjMuEB+FmLmDmFgL5DkK2O+YqGtL9GnMmFhUqEnHmJ8EkKrD',
    'Byas':
        'BBkB6olR+kvzBzbt/BgM/ENhSnHtJtGkE/MzIxS2bzJlBtPwTnTjG1BsL4K6K7T8BnNuW/RqI1FiN6JkGkE7IgMmKkSW8HnKuIuFjCgKwEasI1NgHqBoGhJ4O0TgDxN+GJ2D5P8H7E6SuK2B4J4JO',
    'Devghat':
        'BBaowgRmovzBtJzT9Q5JjLoIxQvDpE0I9WgH/CqJgG+MiNuE+C2GxMsYhL6CesJqKuIlEiN2MlG2DrOsHpFmO4B0LkVsBtSwGrCqE1UkLrLX9N',
    'Ghiring':
        'BBeq7hRg3qzBvEjLlLlDC9FkMnExIvIpHiBgH5cvPnRzD5R9EpBkD1G7F5CxJ4G6BgPxNud6GuB9HuU+M6QlC4M9EnDkCuI7G4E6F0CvC+L2K2CX/O8E+E2c1B+JyE',
    'Myagde':
        'BBOwikRw0rzB7OvIoCvL7NrF2BlInI/H1R/DvJmb+GsM1K+PpD+pBoTkGuPvTuJsB',
    'Rishing':
        'BBas9hR4huzBoLnEtLlLOnbsJ1gB1M/Q/fExQjGgCqPhJ1B3FxNI8VtFcgIiKAiSxIyE8EwClGuH0FuBU6H7IkRuD2RkQ2HqKyQgWnOoNtW',
    'Shuklagandaki':
        'BBauklRg3ozBpK7H/HxTtH8E9DnSzK8E1IwM+FwRvKmGlJwVqEkM/J+Q2JkJ1BmI8NsFnCwLgQ2FnGgP2NuIuGjEkG0IqJn5BrU7UuLrb6FYEjJ',
  },
  'Taplejung': {
    'Aatharai Tribeni': 'BBK2y2Qwiv1B1QrGxTvdnM5EzPokC6B4R6O4J+Z1clBxI2TlJ',
    'Maiwakhola': 'BBLq33Qsgt1BkgBlXniBjFpMrH15BmhB5K8LjDkOqagVuGoPgR0F4Bze',
    'Meringden':
        'BBS4u6Q6lt1BkRoGwBpE9T1T7MsDjpBnOpVwSrHpBlIqP5duZDmajHsO8L2DowB9M+PgD4HtPuOpHqLld',
    'Mikwakhola':
        'BBhB4m9Q0zw1BkRrWjR1GtDjP1SnFe7Q0KnDqDtIpY5JxElIhJ8HxDrGlXpDrBlJpR7DhR4MpLmdtOqH3HuP9P/CjzB0M0GyVmNqOxB7F8LlLgTtD2Z8LyVnEyMqYmU+UoRlC4CrG2X6C',
    'Phaktanglung':
        'BB1B49hRowz1BzT7FY9G5NjS7U3DlT3VlQ1GxBpqBzKuHzRzMjHkE/HvInsB6sB/fW3CsGnRmClU9UxMpYxVoE1Z7L/SuD7LmL2N6QpE4lBsW+XgCqb6Z0hBoI3CuOoRsdg0BuD6a6O8Lqc6H0H+TmToXoYoG8DyMiS2BqJiKySjPyKyRoK/CqO5dsDlNpJ7T8R3H9F7LoMvWvMnbgU7gBtEtpBmLtHgM8B',
    'Phungling':
        'BBQ6+3Qs7y1B2JGrW9XoE/lBnZ/Y7G9VlPxCjLmIsBqIzQuS+oBijBqBwGnK0FrDgR4VN4IkL',
    'Sidingba': 'BBN2x3Q4z31B6L0O8BtG/NvV4LvYrHtQzcvdtM1enJjGlLkD9b7PW4sC2bkf',
    'Sirijangha':
        'BBpB4t8Q6y51B+M8FiH/DlTnXvH5Ttc9H5O7L1C5YlT1kBrZxiBnI4C5ZzhBuCjM/FjMnSpH7M0C3IjLtmBnDrEkSxHxD9KyVmTqNwPzB0JkHiLwd0cwdsHuQ3LwYgOwV7BuG2LR8MtO+KDiKkL8IyDwFjFyS4NwEzDkIoEgQ4T8VgE',
    'Yangwarak':
        'BBO+22Q04x1BnPlWlCqFzZtY5K4K9HoW1D4e8GsfuFoB+KxVyHyDsEjS0T8BOlP',
  },
  'Terhathum': {
    'Aatharai': 'BBKo+0Qgqu1BPvJjU4X1tC+fkNgoBmXwH+M+UgKrDmdtpB5B3R',
    'Chhathar': 'BBN8nxQ2xs1BuCrG1P/UsLzXl3Bgc9VtB7BuPkO+d0TgTkIzF0G0CuKmQmRxe',
    'Laligurans': 'BBMk7yQ8os1BFxVnH/K1TlD9HvHhSiBrLyX2PiVlH+c2ZjIoI9N2SR',
    'Menchhyayem': 'BBKgh1Q21t1B0DlKnEzFxrBhajKibpLsNgNYuL6SgRoB+U5I',
    'Myanglung': 'BBN8rzQ26s1B+I7OlOe1I/JlG8O1SSnI+NlaoI1QueoXoQ6GyNmPnjBoiBjN',
    'Phedap':
        'BBOs60Qgju1BuC1D/T4J7QlBxL7SzXmBvViLnH2KlGmgBmJoO+N5EwMxKyRxB0iBlR',
  },
  'Udayapur': {
    'Belaka':
        'BBa29tQ8/l1BhLjfzB5f9MnY8CtH9M5NtP5FgC/H9WmK9F9CxCkIlSzRT9JvP0B3GkJ2BmOtQ+MqMmErEkMuVkStHoN2F6Y6mB8XghBuGkMgKiMnC',
    'Chaudandigadhi':
        'BBduvtQ+9h1BzFzMNzgB5M7VrNkH5VaoLzJlQzM8GzJdxLnONlL2HlDsPrV8C7Q9FhBkVjMmDJ8EieknBuMpB8QqjBmI8DkClI+F+C+WlK/BgIuP6FuN4OiJpJ',
    'Katari':
        'BBtBs5yQ6v30BJxJlWrKmExP3WvKpBrMjGuK0EqLpEsN9UpKvH4KpKqC5D4JvpBhSflY9I1T1W9PzFjVxJ3B8Z9nB5HLvhBm4BoOuZ5IixBgXwLnNo7BgK1BkC4JsP5NqOkN0dnbwEkE7DgF0HoEsStDeiOqZtJ6BiJoJuDInTmR9IShM0IgH2B3K2J9B',
    'Rautamai':
        'BBX6ywQk290BjO3W/H8ChB5NqL3IwCxMN3J/M7N/NjEjF+HxPoF3f3BlG8HjDnEpDoEzKrCsS0XtBoF0KkF4KqsBxDoQk1B9JuJ5M',
    'Sunkoshi':
        'BBP0pyQok70B5BrI3ZoFlOyLvW3BhG0F2F6EhCqW9JmFF0R8HjDqB6HuOqL2RpIqVxc',
    'Tapli':
        'BBOmmyQ0860B5GtZ1LnJnHpRnJtD5BhJrZsJxOuiB4G6P5HwO8I2J0N/FgR4CmOxL',
    'Triyuga':
        'BBlBwouQ2j+0B7KhuBrKtEuBnF3c3hBBjL1MkBpJ9JnbrIvCoR5XvPjEgN3KjBpQiJoCyJ3GwF4FsTpF8EmJ0JnKuM+LuNoDkTpQkK0Qoe8Q+FsV7CmDrPmL1H+NMoB0L7G0JmQ0MnL0J6VZsNjH2GziByhBhF',
    'Udayapurgadhi':
        'BBfuowQ4j50BpBnMrSuDpH5DyDtFrF/D3ckbpOjNrP6NnC5JxUmCrR0XpHmBR8V7JV5OzO3FqLmf2JqJ+J2MjBCkLkP4LmJvDuDkEyF3HigB4ByPnFiF7HoMSgG7NzG7O',
  },
};

/// Boundaries that could not be joined to a canonical roster entry.
const Map<String, String> kUnmatchedPalikaBoundaries = {};
