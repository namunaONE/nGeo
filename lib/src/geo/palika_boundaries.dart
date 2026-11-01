// GENERATED FILE - DO NOT EDIT.
//
// Lossless boundary geometry for local bodies (palikas) of Nepal,
// encoded as compact strings (format version 1 - see
// palika_boundary_codec.dart).
//
// Source: HDX COD-AB (Survey Department of Nepal, CC BY-IGO).
// Coordinates quantised to 1e-4 degrees (~11 m) and stored as
// zigzag VLQ deltas: the round trip is bit-exact.
//
// Regenerate with: dart run tool/generate_palika_boundaries_hdx.dart

const String kPalikaBoundaryFormatVersion = '1';

const int kPalikaBoundaryFeatureCount = 753;

/// Total boundary vertices across all features.
const int kPalikaBoundaryVertexCount = 16748;

/// Features joined to canonical roster entries.
const int kPalikaBoundaryMatchedCount = 753;

/// Encoded boundaries, keyed by district name then local-body name.
const Map<String, Map<String, String>> kPalikaBoundaries = {
  'Achham': {
    'Bannigadhi Jayagadh':
        'BBLg56RijzxBxCnL9ckChI+GoEuEA+9B6MI2PxQnB3lBkDtKuEQ',
    'Chaurpati':
        'BBbur8R81wxBrDvJ3X9M1ItB9G2KtIhDpPvc7BvX1FiClB2J3euMrWoZoHuUoR+UoHsQhDyD0N8HgR5EZjN4EtD8PmJEnV8LkCyJ5YmN/B6J2K2E1C',
    'Dhakari':
        'BBSsr3Rw7yxB3HtdlHrFZrdlUNzK1PqCrIzHf9ByK1dsnB3Fme0FoKnH+LsNySmR0EiWyT0Lc0a/3B',
    'Kamal Bazar':
        'BBRq24Rw90xByEvEnH5IuF7T7axBtK1dpKQhYmxBgL4czJwZsKkHuLnQ0Q8BnD1HwQ7MwTlC5DpJ',
    'Mangalsen':
        'BBWm15Rq90xBQ/3BzEvFkErN5EpOzI3DiDzD9Mla1LrLlFvT1K2BxC+L9JvElawOasd6JwLmDsZqKPsK0d+a0B1D0ZyfqH',
    'Mellekh':
        'BBQi48Rwi0xBjJjJ3EtU5VnUhGa1HgW3F/JvNyGvDwrBkSykBmNyLuM+DyDnLiK/F3K/TqZzb',
    'Panchdebal Binayak':
        'BBUi55Rwx3xBpC/OjSzQiI3I3C5G9KlDlBnYxRfpWmQoD0H9OvC3KwLrCuF2gBma8HqZkW4iB2G7S+JzGT/PoMzG',
    'Ramaroshan':
        'BBTsg8Rs22xBpFvShZ3PxQjgBtQgQ3exMjMoG4IyKE8W+KmD4C6GhI4IkS0QqCgPoRnDwQiDuH8HuLhDuSnf',
    'Sanphebagar':
        'BBf8s9RiwyxB3BnJlH8CmEvb7JjB1IsL3BpM1OrBoGtStOlKjRuFzFsV1LrCJwV7PlJ3EuDakN/WgC6FkN3DqOiI9G+cjC6DmL0GvF4D0K8J1W6GFuV+XgPhKwGuDuMlS',
    'Turmakhand':
        'BBem42R811xBmErKhFhVlSxDhWxTnQzF7LwZzKgH2B4QqNkZvMif7ZTrHgRpM6EtLmPhOrE9LoMrHtJgE6kBiPU+KrO05B9d4C7K2V1PoH1NqLNBhI6X/MgGqFoH7P',
  },
  'Arghakhanchi': {
    'Bhumikasthan':
        'BBgB4pkR+/0yBoKlB9W/RnHrC/BmGtLyDtI3B9HjN9JudnN2KtV7BlC4JxHqCmF8PvF4PgHuagM8B7E7D8FvF0HgEwIlQoGhByBlK2KxB8B3L8NmJiH/HB4JyH9CuLliBgJvDdxH',
    'Chhatradev':
        'BBQuwkRq34yBGxEpVsM5M1PlQ7BpQ0Y7YkGXkfsK8TmJLH3MsN9KnBvGoV7LkRpCkWjb',
    'Malarani':
        'BBV+hlR4l1yB/XhGhS+rB1I4EiG0O5MsWyKgPtEmL4MyPqVlMpP/RgG1PuJCvErO6KpCrC9P2L7CiBpMpGpClB7J+HnP',
    'Panini':
        'BBZk8hRgz4yBoEtG5T1ExC6K1N2F9EpF7MsHvE+KzSrIrK2E8JscjD2YuPgOoF7FGwKqJiIsVrUuLuGHxR8P2G/JlN4ClRvFlGkJ1IqBjY',
    'Sandhikharka':
        'BBdq0jRk/2yBlFvYlHgIjOnJ7B4L1KyBxBmKnGgBvIoQlI7DpFsF8E8DpEHhLpH/M8MwIuMrIuDVsK+EqFwNxF4C9K6T2EzF6eiThFwPlYoVjBOzIxK/OyLnW',
    'Shitaganga':
        'BB0B2vhRuk1yBmBjlB5Q/QoG9MjIpLqF9FnF9L4ChPzQ5L5GoC1BxKlFsJzNhgB1HxE7RsYmHmEtHoDHm+B5FsTiHoT3BsWsRwOzGnCphB4WiJsXqHmCxIkEzEwNuEsDpJ4kB4FgZvH+M0TyH6EpIqLyB4JjM1G9LkDlG+IxCuR6I6FxLoN1HG7JsItDzInM2FRkI9OpEpSwF3PnFzP0HxCwG1Q',
  },
  'Baglung': {
    'Badigad':
        'BBc61pRmh7yBnTlzB6EhJ3MvJlJ7RkGnHhRziB9JnCQoT3EgE+MuPhI2HgI0K9zBy3ByBkF8K8FwDoWqHuGyLjD+EhIuISqElQ2P1HHkHmIyB+DyI+N2EsG1H',
    'Baglung':
        'BBX8hpRojgzBrI5RnMM7H8J8G4F9F8B3FrBtHvQnNgPvIpCZpGxJiCoE0e8I4J5MxD8BoIjMmN0BkGqLwM6PlCiSrkByYnFsLxX',
    'Bareng': 'BBO2tmRw09yB/I7dta8UuEwfpIIxDqHwIqPzGqc6FL0F7MyWvE6E7JhD3nBmF/F',
    'Dhorpatan':
        'BBY6lsR2l3yB4CzI1JzOyHzblH9MnF6G5MqB7yBw/BtOEtF0WjPwLqD2L4MwJ5EiJyT8yBqMvLjD9NwF5WuM9KpNzJvDvN8D1Gw+BpH8Cza',
    'Galkot':
        'BBbyvpRwq7yB7Z1PHzHzP2HrEmQtIR9EiIzLkDnHtGvDnW7K7FyEguBhVmSmLsbjFoMoBunBgR2B0FzK4ThMO9RkNjKhGnGoKxQvCvLuSvR8W3K+C9H',
    'Jaimini':
        'BBT6lnRuihzBzIjKzErd6JpF3HxR1IzC/FClL2PlREnF2M1LBnS+P2UiPuQwV8IrD0UyIgMhQ1B7IsM4D',
    'Kathekhola':
        'BBS2mpRm6+yBvF9L9JmC3T9K1MyCxWsR3FmOgMqZgNhFyFrKwHuQ4FsB+F7B7G3F8H7JyKyC8H/F0G/T',
    'Nisikhola':
        'BBUonsRu9yyB/CpGnNyExL0R3ToB1CkR9XgHN6P3QiPrJ8jBvcyWyRqiB/DkL8SlJ6FjXoJsC2KrHgtBj6BgStHiI7oC',
    'Tamankhola':
        'BBT87sRmu5yBpKhoB5OwB7EhGt5BoG/D4GwDwNqN0JtM+KpFoc8JoJ+H3CgOkJsJ9NyHnB+CkLqJoG+TxQoL3f',
    'Tarakhola':
        'BBTojqR477yB3K9b7L8SlkB+VlFsGuC6LzJ4JV4JmGgDjNkKyCyMgNvCoT+K6NKsEzY+RjUpB3UwJ7IJtK',
  },
  'Baitadi': {
    'Dasharathchand':
        'BBfwviSoijxB3ClN9gBpYyB5JvESpCpNhHb1FuKzFhG5GgQlHiCeoRvLsJ+E+O3KGlDtFzBuI6EuRwGtCqF2H/F2O+Q/FuG+GyPvQgOzDwGnR1CtIyM7B+D3GqFqL8EjB',
    'Dilasaini':
        'BBcqlkS+ppxBMprBlLlJ5DpO8FnL9BvlBpe1qBM+oBhOocmE4WzGgEiTiDiIwLoMlF3EyL+G8BxBmKzImM8BqE2FjEIkF3IuOqCiKmJ0CrB8FsGqCuHlIyClP',
    'Dogada Kedar':
        'BBSy8iSuykxBvJ/MWtcxJpF3EnLvE2GxM8B2CuI5G4NmEgRpUwP6H8PvDqXqRJ+G4QkRuC8OjdH9hB',
    'Melauli':
        'BBbyggSqljxBvQn7BzFvC3EuGqFqP1VHlD9FzGsNzN1M5GyC1MvGnEqEmIuS5CsI8KW+L4J9DsGgTkXuFnG0K0EgE8KsN7F6DqD+FlJ3GwBxDpZuN6E',
    'Pancheshwor':
        'BBeyxgS2vhxB0C/FpIjE5GlRnJXsCtKpIhG/OgI2EvOlCtEtDmDxChTlVpBhMgVlNnCR2HgOyJ9FkQoHgDEkLqIQmC1G8G+JkP4FkGlL0FwCmN6qB8J7HlB1QwLtM',
    'Patan':
        'BBmBomgSszkxB6KzG1E7E3QgGgGpOzDjHrHmJ5DpD5LmGzFnL5KzE9EsG/C9HxD0DxGxItC+D/D6JmImOxDqVwDiHsM0ClEiP1JuDEwV3IuV4LyR4KjGmDsFjD4Z6R7cgV8B0FpG9DzZkMvOuBrP+FL5FpHzCjd',
    'Puchaundi':
        'BBcg1jSkkoxBlGxD4ExLnMmFlIxL9S/C0G/DnErW7R9B9G3QpRKqBiU5HqD+IsjB1O+aOiPkOAbsO4fyJoTxDwF+FoD3RiJWuI5NC/F3FiE7B/EsJ5T',
    'Shivanath':
        'BBW2n/Rq9hxB0EhE1FxHjRvEjHhKnC0GpIPDjLnH/C+FjQ/NxJS1HzZmMxM4SwR6fkKzE2MwG6GxC0N2M0GrNmD+FyRM',
    'Sigas':
        'BBZ85gSygpxBf/OpYnNvBxUzFqG/U7BnLmYzM8G1Fqc5IlDlM6Ob+RoK8M7C0JsM8FgH/EgDuOkS2Ua1PsN7EiD7LmdzYzF9RqK3E4FhX',
    'Surnaya':
        'BBWq0hS8mkxB3DlMnNoDnKiO7SwH0Cid6FqH9FMpBkP9ImGrDgRkF4EMghBoUkP8JvGmIpT9IpjBmJxItDxWoEzP5H7PmUtQ',
  },
  'Bajhang': {
    'Bitthadchir':
        'BBR4uhS6yqxB/HlvBjOAzEmUpK6E0F+Rld0YhD8LrN8EZ2PsP3H6QQ6KvMkNkB+IlMI9PwM5F',
    'Bungal':
        'BBpBg3mSu0vxBpE7HppB9FtM7R4D/GvEnUhMhIwIhWlS/uB7LlPUxbvGxCa1GxI3BnC5JhJT5DiS9EnGzMqEzfhHkDocxNqHzB4K2S+LnGwHrGzFb8NwHyIMoL4IgH9C6H2FmRyXiLuGuR8diKwMiOhF0LsI2FknBIgawIgR3M',
    'Chhabis Pathibhara':
        'BBT20iS24uxBH7V5WrK/d0U/PmTtQe2I0xB2FIuEzI2C2E8E9F4G+EmFxGgJU+G3NuLtGQlToNJ6FxH',
    'Durgathali':
        'BBP2giSi4txBxH/EjFtPvD+Fzc2H9CoIhOjG7FuFoF4HnJiMMsRiE0FgPxBmT/U+gBtU',
    'Jayaprithvi':
        'BBf65iSw4xxBnIzT3LSjQ9OyDhDtEpJpPxClFyG3G9E7E+F3DpErDoI1FHkB0I1N+O/FiUmCuKhGgL2HgQN0fkcjqB4N7KmEnNmEqJoM+F8IxKmLgDoG5N4B4JuFPevL',
    'Kanda':
        'BB3B6/qSm5vxBtYrgBvVvO3NkElOjM9HQxKuPtPmI9ZFlIsOkF4MhRsM8KqSlPsgBrhB8PpQ4X+G0G0B0dtG0F9P3BhQ4VwBglB7K2nB+M2csNXiGkGkUhK2GkD/DyQwE8HmKkFiP1IwJqH+ZkEkU9T4GjR5C7V2G1I4M2D8SnG4N+KsRlI0N7iB3JjMkCxP2Vl1BtIxVhF8J7H/ErCpR4JjOvHxGO9VuF5PmVhV',
    'Kedarsyun':
        'BBayzhS6+sxB6C3E3I/GLnLvHxIc7N0F0F8G7FnGjGnN3BzG4LjNjB5KwM5QPnNmJ4GgBsFoLhBwhB+L0SoI7IxD7KsK9C8H4G+CnI0c1HgD7J',
    'Khaptad Chhanna':
        'BBWumgSw9wxBgBlM5FgDXvIzShUGuS9GKxF6IjHpIhDiYtHgHqIsS/KiU2B4N6MwGqQwc4LjS3GnbiG/KlCtKgGhUiL3M',
    'Masta': 'BBLimiSsozxBvCnOzYxPlEpJlEoN3N8KjckqBsoBuiBuQ1PoO9sBoGV',
    'Surma':
        'BBZummS20wxB6IlGpJ3M/ZvIjnBHrI1FqFzK9HtKnfrPnLoR9NWPmTtLuGxGoN8H2EhBkKwNiIrCqEgToE6F0L/BiS8ZuH2X3KoZhe0jB3O',
    'Talkot':
        'BBjB0vmSk4wxBLzJ9egT7N+BhZ+dnMqCpF6HpkBvG3B/JvG+NlL/CtMsK+P6J4EoNxI+BjNkrBjR6P4H+VwQ2B8I6KgXkBwR2bmC9aoGzJrElQqD5V0P3U+P4B0G/F5Bnd7G5GoQxXohB3P4DrQqK9L',
    'Thalara':
        'BBRwmgSquwxBnEnjB7IhNUxU9LzSkBphBtFtLpJG/a8Q2B2TkMyhB8LuIwFqY2HNgV4bK8H4E1F',
  },
  'Bajura': {
    'Badimalika':
        'BBVi4gSk14xBjErVlH/H2Dlb3VrL1K8C9HzW3HhCjTqJsLhK5FlK1qBwkBtBkwBuHyY8b2HiMuM8KsB2N5KiS+DqO7ZmIyC',
    'Budhiganga':
        'BBPoz+R+t1xB9GpUxL3E+D3I7TjHnClO+H7KnRvIX6G3KjLjQsJqF8QyX2Rud2rB2O1G',
    'Budhinanda':
        'BBXsnjSm64xBiD/DlnB9F/V0WvP1T5OZpO8ZhS9D1N6KrNtE5D8NkdsZiEgcsJuIzE6E6OsBuJlDwElJycjLqc92BgM/CgHlPiJtF',
    'Gaumul':
        'BBagvjSi04xB+L3F2CvH5OlP9O/qBnd9FjN3MxLezFpS1b9TtI/OxHnCnC7LrEkBlP4buH0GGgpByFiQ2K7C4VsL1DmbsLoakV8UgWzW6c2H4OvD',
    'Himali':
        'BBzBk5oSo17xBkF3GzF7N8E1MhGrLiDxIlIrGmEjLxIlWNxUpLInGhHnKwW1Q0O7ZjEvJpH/O2InKjFvE7HgExQrHpDtToKhGjG5FuCnCqJ1c0R/GmP3L2Cxco3BxckLpGqK1WmBgJ8F6MojB2esLgY1FkGlMC5U8M/QqJtG2WvB8iB4SqkB8H2DoVyFmEkUKgGsIsgBqDyGpNhB7mBuTjL',
    'Jagannath':
        'BBS0w/Ri77xB4E0E8EpFrJtI/D/blVxW/GS0B/V9TrJ3VfgMqjBtJsQvV+C1CwN8K8rB+E8D6UzOy4B9J',
    'Khaptad Chhededaha':
        'BBWwr/R0i0xBrP7d5MtGhBtPhZ5V3L2hB1JqJ2EoGa7GoRwI9H6KoCoOwS0FxCoKyN4HoKgevKyKoS5JuLuEvB5kBtHzG2ItR',
    'Swami Kartik': 'BBK0ngSmg9xBnJzaxQtLl2B2K5U0O4bmJyB0RiqB6LqbzMiC5M',
    'Tribeni':
        'BBRyl+Rs51xBnNrZ3hB1hBjF4Q9SqPK0HsL2JlQ4V0GsQ3J0P6E8J8ViPMgKubkW3GtZuBjwBwdjb',
  },
  'Banke': {
    'Baijanath':
        'BBhB+gpRqt8xBiMxVgC5RpGkLzIhIsFhB7VlJiEtF7I9HrIiE9K1V/H3D2CzKjO3KCrGvGJpHvUlTvF1E6FuG+Gf+JkGOgJ+RnOiNpJvHtE4C4G4PugB4FgC4TqLwGgF+QoYoGoYgP',
    'Duduwa':
        'BBbkolRy+7xBjI9QzKgCpD1EnD8EtE9J1FqFhJtDxG0GxH7F1G2GlGhCzG/IuUtOrR/MtI4sBhd2kB6I6E4DtI+VTEhTkNgL6RKwJjNgVoLvB/E2RvI',
    'Janaki':
        'BBSs3lRs96xBrM9mB3T1MhBzM9MsIqCnM9F6FnC9M7FhBjS6e2d8BrEmRsKiDuIuOiK5HiDqVmJoDqJ9H',
    'Khajura':
        'BBd0ymRov5xB1IlSjGLgB/JtG9G0EjG9E0B5GpO5RoBlGkGhC3ExMsNnF/MpEUzJuU+FkBX+JkDiD8DvIoCmQqK3JR2KqV0OkLkb6K7ChKnXyE5CqJwHwN7M',
    'Kohalpur':
        'BBV0/oR2x8xB5HnMrnBtN/E9QpLvG/B3TviBzF0EgK3Ka8CyLzJuCagOtHoNwoB6UkTub2U+G4PyU2EtN1F5I+M7DwLhb',
    'Narainapur':
        'BBO03iR0k+xBzD3K7J/ElB3dxI6H5I5E90BowC4BuZgKNsZmV4MTyJ3gBiU/VuFpc',
    'Nepalgunj':
        'BBb4ulRyu7xBjDzNvFgCxElH0EhJzEhGhK6HtItOrKhDsElR1d7BzO0X2RmOtUuO0GgJoGiC0G1GyH8FwG1GkJwD2FpFuE+JoD7EyG+E2EnE8J4LmH7I',
    'Rapti Sonari':
        'BBoBunoRoo+xB7O1V5UhHjTtb1lBlS3UqJuBiFjQ/LrO8NlRBnI3K/GM2B8RtRyBhCuFqFqC7BsWkQyO7JuSyB+KhUgWtG6d1LiF6DsSrEyvB4SkBlCwfuI4I1F0kBoxBbwZh0B0Q/1B0YhDgYzTmUlkB8KnDuKlY/C3NmKMgM/S',
  },
  'Bara': {
    'Aadarsha Kotwal':
        'BBSmkvQst/zB3FzGChTpO+ItG1SxQjF+D9E7D7CxKmDgPwS2D4S5MOtBgN+F1DwHwFkFvJkEwHqa9E',
    'Baragadhi':
        'BBPk7vQ2x/zBhD3TlLgFkB9HwOpEzF3YrF0H5ZDpJuFyByRyO3ICuTgR0S8KrCKhG',
    'Bishrampur': 'BBJi3vQk16zBWnH9Wxc7IoQrDwgBoJemCzSyL5CqLuH',
    'Devtal': 'BBNkgvQmo8zBrT9DhH5EiBhGlQzIrCwT0LK3B2VuJqB+H3PoBoL+HsDuH5R',
    'Jitpur Simara':
        'BBhBgv2Qij8zBzI7SzTsBjL1GpTiL7iCxTlXuGzJrItLZ3F/JjL+G6HiKvBgOlIgF+D6P4c2PjIqNhGO4G6LpJnHzIoBJ0G6M0MuL9H4f0BuC3HkbxEge9WiMgD+NkNmlBhG1E/YuHhE',
    'Kalaiya':
        'BBawyxQu68zBjc/Qnb5nB5DkN/JpDOyFlJuF5J3JkD1JtJpBvD+NpNqHkJqNiT8C+C4O4M2E4ClGmDqKuN2HEoHuW6DM7EyIjBqJoH3G5LuNlM',
    'Karaiyamai':
        'BBTg8wQo89zBK/HvO/H5KsB9DhKzG6WpOvErEqHrPsBqB8GiM6DwO/DyErHkH0aoL5GyNyH2FnJ7F1E8EnP',
    'Kolhabi':
        'BBX07yQ8v/zBnNj4B1cItL+H9JhOzEmnBvOrHpbyJSwJwGnHgF8ErBgK6E0B9EyQmF4B6EzM6B8OqG7CPpIgK8KyX1CyIoG8mB3V',
    'Mahagadhimai':
        'BBU++vQ0j9zBvJ9E3D5KlC2G3M1E5F9K9GsPxGvOtJsQ4G6EvFuHoNiE7PpDxE8OyUoJyH9GyJ6CsEpH2J4G4KpX',
    'Nijagadh':
        'BBXiu2Qwq9zB7BhKjlBiGzZnQteiXjbyExC4MqKoxBtnB+VsF6IwUkQinBkKsDuF2BnImMpJnCvf2K5WgN/GmGvL0P/FkJ1NiPnCiEvT',
    'Pacharauta':
        'BBS83uQ2k+zBrS1M/NG1EnOrOhFX4FzGrT3MxElB+oBuIhBkQgL6ClJ4OU8D8CvEuEkR0FmB+F8M5K',
    'Parawanipur': 'BBJi7wQ2o7zB1GhL+DnMrYzLKgK2KyD5GmSuOoIwI7E',
    'Pheta': 'BBLi+vQoi7zB7FpMvMrI1L6CnFqc6J4JmJtFNxF4JyDkBlK4FlC',
    'Prasauni': 'BBMw6wQgw7zBrWvK0BtHmEqBLzNlSnEPuLmMyOGsM8SgR1DnLiIxJ',
    'Simroungadh': 'BBM67tQ6m/zByFlB1D9SlQ9U5F6HvO1ICq2BsMnIgCqHoLa2BlNgHa',
    'Subarna': 'BBNw0uQwr9zB1MpC+ElIpQ5HsDxU3Q6Bb/FxI4lBwNgEI8I8IoIiI9RmQoC',
  },
  'Bardiya': {
    'Badhaiyatal':
        'BBiB+tnR661xBPzGtI3BnFoQzWhBxIsWvMmClOqVpWvDvIyQuELE2IgFiEyMrNiC4EmGjGuRtBsH2OyNzCqC8G8HR6HgV0JhEpB3E2EkDuCxGnJhLyBrP7F9EuDlLkIxBpKvH/BpY8O5M',
    'Bansgadhi':
        'CBfkipRgz3xBIvGtUnLtJrOhHYgBzHrPnBlJ/H7GkF+BsYqKwHjIyBnD+M2FmDxBsPoJiL1MqMyRmR1C0KgI4DiL4VoIjEwJ4G+ExUhK1OWpLiKxJ1E9IsGlLpDrJ0JtPBPyxB8jEsFzF9EsCrGxHawIjI3B3CqL7LZPpRhIjG/B6RnJ4J/DkRwjBuN0P5oB',
    'Barbardiya':
        'BBb0lqRyh2xB6HzOmQxH8GmDhF9XvLvM7O5DnDvJrUgH5U3EtI1I3LycuB6O5KgD1C8HtHjE7D6VpHuEqJgIsPoBf0HiHXigBsfsQtIjDnUoO3IyFlL',
    'Geruwa':
        'BBRk1sRwsyxB+jB+OkWWzrBjyBlO9EnDlJW+JjLwDrDoH5IgCpL/InVsLuC6NmWjG8N4L8HvE0LsI',
    'Gulariya':
        'BBW4uoRq4zxBnNiE3SjMtXiZ5RO1BlMjLsQhH5HsD8iBmIuEkGlHoH8ElB0WsWeiFlQ+I0BmDzLuHkE2C7H6K/CtB5OoK5Z',
    'Madhuwan':
        'BBWsqrRs9yxB0DtD9I7IGjN1ViDjQpNvD0MhVoNnWjB7hB4d4SmM8O/FoI2IiX2EyN/EiJvLiGsB6GvT6HoB8CnFwIsFsD9E',
    'Rajapur': 'BBMuysR4ixxBpY1oBlfjUrO+MjN6mC6QqNkNnEtC5N6HjHuNnEsMkJ6V1P',
    'Thakurbaba':
        'BBZq/sR8v0xBAlRpHlJ5X1SpHc1DhFiK7CpZnQ2GwQlGyGxItF7CoF5HnB5GwThGrBnGkJgF+J6R+F0LqQgLzJsIuEoIrOkJ8LkDjHgS6B',
  },
  'Bhaktapur': {
    'Bhaktapur': 'BBF268Qi9k0B7GnIvD7VtGoawQ4D',
    'Changunarayan':
        'BBOsy9Q+pm0BhIjc2HpWzClL5MzP3L0CxEqEmB0P4H6J5Q3DhE+e0TmH+CqLqVJ',
    'Madhyapur Thimi': 'BBFsi9Q45j0B3MzVlJlDoGuhB0PpI',
    'Suryabinayak': 'BBI4v8Qihk0BD9XnH3C9ZmkB2KkWlH6FmRgTwM/3B',
  },
  'Bhojpur': {
    'Aamchowk':
        'BBV0qwQ8yi1B0EhC/FxGrR7FnIgO5NpGrH4Jzc3EvOtImBoQxG6B/FyNiN2Y0B6fsIgPqH5MsbEkc3X9FpO2S/V4D9T',
    'Arun': 'BBO+w0Qium1B5FtU7iB1L1EmdndyD9Y8fsB4G2Vib0Tc0K9PkQ9F+R3VmF4B8GlZ',
    'Bhojpur':
        'BBUgw0Qkyk1BuK9J1NjLuF9JtI1C1ClMzOnH5rB8VhXmWoB0N/PwPgOxDsH8F0PjB0LlH8Q8H1B0GknBwOpEjYwG3S',
    'Hatuwagadhi':
        'BBR84wQ87l1B7ElfhRjGjJnLjc4X1bE/G2M+B6S1G6F8IqB+ElGmFkIgNVga8XgWtJ2DrN8O3P',
    'Pauwa Dunma':
        'BBR8mzQk9l1BuBhVhL9F1JtC3H2HzPkBjEtFhQyC7NqL7C2PpNwL1DoNoTA8TmV+Y7fidrDsD/N',
    'Ramprasad Rai':
        'BBP4myQ64j1B/P10B7NhRnIoSlXsOtCwS5I2FzKmWsPwUiRkGgFiY0X7VmGlInBzN+Q7P',
    'Salpa Silichho':
        'BBW8r4Qyrl1BtBzX7LtJsEnJtH/TwOzrBhKvEhG9QlQ4CpO2MzJ/DhgByb3H0LuCgOkZ4NqE3F0SiD+UwuB1E8P0J1BsMiKgJhT',
    'Shadananda':
        'BBRmx3Qmul1B3Up2BzShDpE4FvXhM5f0mB3E+P8H8oBrHsZ6FjFsC8HwVnF8IhM4WqGwajmBgMhCsDtI',
    'Tyamke Maiyum':
        'BBY6r1Q2yj1BF9U5HnMvS9KmB3TlLpN5Q0UjMcjVxKtIoGnRxD3I9NtGoFzE6IgP8QmRy0BwwB1b0PsI2BiLwI8CvF4J0LiIoGa2M3S',
  },
  'Chitwan': {
    'Bharatpur':
        'BBuBmu/Qo4xzBvHlW9PRlIqSjMkHkDtNpKtIdpJ1W+E5O9fuN7RjEjNrTlJxH9X/W5ZhShjB3OpLxDsM0KkUjMwLwFsJpD+c8DoG5I+MkLoVrHyToHiFK0RtHmG+J+JfyMkHjDjCmHkGkF6ZpE0B6G8iBzI2NgGmHoTmRmGmM1GiKsF4L3FmDjM+GYmC5R',
    'Ichchhakamana':
        'BBiBqxgR030zBzFrHmFjLtDrG3GzCvD9K7NnCjC5UjK/C+C9M7GZnDmMzL4FpJvF/M6GpLhFqCqQjFdsH+N0R0E1DqGwHgQvW0SvEkX0E5C0MkH4EhI+H8D4ChX2K6E4FhRgJmcyKM+Yjb',
    'Kalika':
        'BBZ8q+Q8z0zBBrazRzEvHnOoFoBjC3P9IvErEtQ/NhG/MuCzD4D+FyNlKoKuIkEwH8QtEiP+FwEoCuRzP0RsK8G8B4P6YuHyKrVF/M4SrO',
    'Khairhani':
        'BBUi38Qmn0zB9G9HiCjOnY9C1LrMzJ0IV9K5HwK7J/TpK0E9F3FXuakLkKkEwsBM/I0LtDyEnL8S7Kod0I6FvE',
    'Madi':
        'BBaip5Qg5tzBgDrClSDtI0F9MpJ3VgPvMjB1G0JuDwF7Ng5BoB8evJwS2EoDvCmGgImBkGmK+CoWoQ9XsE9coMrNqHreoW7kBG3OkIvDYpPuF5E',
    'Rapti':
        'BBZ629Qys3zBxGvlB5ajJrCpQrK7GsP3QxBtNpFuDndzI5S6KzEqLzLuDgFqazKsV6K0PkOkF0W3MkKyIF8InFjB+F2O4SsPoD3D8JyGuR7Y',
    'Ratnanagar':
        'BBY608QizzzB3H5TtIjEmKnKjG9P3R8EzB5GrRDtIuEjGjFkClH5DsE3E7DoHyM3QgHtD6JkFsFkLnE8JgU6HvKW+K0JzI2LsM0a0E',
  },
  'Dadeldhura': {
    'Aalital':
        'BBd0g7R03jxBlClJpQpH5Q6ItQnRtgB9CnH0FjTvHkC6KhJwatYmDfvI1GhDnCqS+MwV8JZgZkRuM5SiKjDoIiZ+PCmCqPuJU+OkRkXxM0BvTmF9DzFzTiGhjB',
    'Ajayameru':
        'BBVuy+RqplxBnM7CnE9JqEtSlIlOuG3NlGtKgEnGhbzRvP6kBqE8N5NmJ4FmNrFuEkGkJ5FmGwTmame2SiE9Z2JtD4DxO',
    'Amargadhi':
        'BBV419Rm3mxB+KzBnnB1bnIxT9LyFhKlcjNgDsB1MnPtKhGggB0F0TlF+DtC6UyJuDgb6fwI7CsCoKgJ3EiIpagT2GgKjD',
    'Bhageshwor':
        'BBbys9RirixB/EnVpH2ChHjG2EtF3NjMW1KvzBvQpJwCjI2LmHwlB2JoMsE1EuJuC3Ko3B0PuLrB2MuNzC4J6bwPtJjGjJsFtE3FlN6NlJzCrV2KzYoIzF',
    'Ganyapdhura':
        'BBQsw8R29oxB8DjB3Izc8D/HlKzPzI4CrhB5iB1PoC7OkKyI0zBsYuB0ImUgOiLqPjPgKsM8CtI',
    'Nawadurga':
        'BBV+0+R2+nxBjC1M/KiG3LxRyD/O/T2C/S1G5MwesEqK5D2O8HyR1KkW0IwCmIhKsL5BuKuD5DyEoI4JuJ1O2IsDkO/wB',
    'Parashuram':
        'BBpBuq7R8rixBXzJ9MqD1JnMpH/kBoIlMhNjD8PnapLnEtJ2KvNIjO8ItPvY4LzenfgBrM2PrGKvH4K6EuQtE+K+H2R5Cyd/F2E2B8T9MwU8G0Y1L6FN2FxGbG+HoZzCiJvajC5KkTwH+GzFiYa0P6FwJyN6Q5IyS2K2JzlB',
  },
  'Dailekh': {
    'Aathbis':
        'BBV+h5R+q5xB/b5qBjI5ZjmB3hBhIoCxExFpL6JvHpBjG2F2BsG/Le7R+U6MyX0CvFkP+ImJxVoQ1C4Iga8TmL+D0NmzBoK',
    'Bhagawatimai':
        'BBUuj0Rwk/xBhD5JhiBrcnCzShIvHkClcnMwD7FsNrMuC5H0R5M6D/EqJ8MwR6DobuJwCqL6RuU3O4WtGoQgHsE/H',
    'Bhairabi':
        'BBY8r3Ryv7xB7F1XkE5MxHnKvFsEtR3D9G4GntB3QrH9E8F7CpIxD5F4PoD+N7KrD7LwItLia0G6EiiB7V0XqI0RxJwPkC0DuQ6SyPiL9I',
    'Chamunda Bindrasaini':
        'BBQuo2Rml6xB2FlKtOrQ1BhQhTlL/U1jB3FoD/HgQvNyKqTqKoE2SzEyFsI2D9F4C00B2V4D1C',
    'Dullu':
        'BBQiy0R+m5xBhEjTnTlMpsBsVxLyOyE+JpP2b0FqX2b8GyFhI+J2BsLja8LvI8KuDnD/N8JhU',
    'Dungeshwor':
        'BBSk2yRgo8xBpF5FwBhUjR/CnKhQ9LrFxOoCuC6X3OoVwDoUsI+FjCgHiGoI0PnBiI7RsMtC8FrNmMtD',
    'Gurans':
        'BBZwnyRg15xBzEtJtOZpEnU7W+RpDoQ5KuJuBuI5J8F2BwWxVopBpFoa6JRsR0RuYyC6FpNjJtKkCjHnGdzFnZ4OnVtC5XwNzCgN4FwQ9lB',
    'Mahabu':
        'BBS4g3R447xB5SxPtDnQrHzBjND5MgJ5Z5HpeiU8L8OiQfyMuQ4LzC8I0IuIxEmC7IsXuHmE0HqM1Y',
    'Narayan':
        'BBTqu1Rm+8xBhDrS1RhBnMpQlQgB5L3O/MrFpKiI1HtBvBoUuHuKnEyXgIqHqHoWkRhlBsX0IiJ9KkSsJ6GrF',
    'Naumule':
        'BBXg42Rsk9xB9G/YnYjIlC+IvIyE+BgM/IiHxPrJzL8KtXzIvP0pB6b6UuB4Q4M4DqO4S4hBzC2FrG1JhXUnP4HnS6MlQoFmBuCjN',
    'Thantikandh':
        'BBOst3Rsj5xB5C3P7TlL3I/ZnQ2ClJyV5P1IoGsRsT0LsB0PqNkNAqKiU2BoMlgB',
  },
  'Dang': {
    'Babai':
        'BBd0soR0vgyBnI/HvQ8M9G1QnHpDtjBqwBnSqM9V+B9NkoBwUmJgViXqEsQ2HrH4VN6hBoM/ItQgJ7G2E/T3NjUwCpK/Y9VoMlPwB5M8LxFYuH2JyF7B/IuMjGqE9I',
    'Bangalachuli':
        'BBaq2kRoqtyBhR7T1FvenM8O/Bod/NyH5CmL9PlOxPiI/T3PrJ66ByGqStI0iBhHoFmQjD6CgEkLjP+LmJ4IlCrBjK2JlD2Pvc+IciLuNkOr6B0OpO',
    'Dangisharan':
        'BBTgylR+vlyBgN7F/RvL9KW7E1JwK5blRzQ7IAtU80BzU0byJsH8GlImFqL8M9TsW4dyK0CJvcqFuCgFvG',
    'Gadhawa':
        'BBa23/QmyryB7BrT/boJxQjE9GoFtHjJpNkBnCxJlZ5C4P+/CuMqc9E2EuB+UiZ1FmB6Q+K0HcmdhFesH2NsPxG9G5EiS1YlDhkCsBvSmJvKwCpxB',
    'Ghorahi':
        'BBmBg5lR2jqyByClFnQrE9F7UvasBrNniBvS9BrDqNxLrJpEmKxRjOjTymB1EghBzNuXoKgLnCyLlGYyDwNhJ2GLmI4O5F0G4XkP0JmMtJiTwP8ClLgOxHgCndoM7O2FweyVgQqJ9RgNnG1CpLoL9VjMjM0IpD4CvZ',
    'Lamahi':
        'BBiB6tjRmslyBxdrD5kBsiBoJyJnHkD9HqY3K4L5DwnBlKgEEoLnH8ICyXxQqNmF+LnGkRoDs1B8G7C4LkIufuCgG5mB3K7E1HuGtBtEoK1JlDtOmGXmC/KlKxL4NzXyE5gBoWh1BiQtVe9NsT3jB',
    'Rajpur':
        'BBfi/hRu4lyBgOjOrOJ2FzkBtI3IuChf5Q9C7lBukBvE2QmFuCtO+hBhsB47B3SynB7Y0VjQ4nBkZ6CqCyJqNjBuHkJ+GnFyQkE6VtG+UzMiIrtBwK7E0D5mB4K3L+HpYoHjDnJxJuTxR',
    'Rapti':
        'BBSkphRgwvyBtFjS+C7jB1c7B7LlI3G+CnD1J9H+EoB03C2HyEgOsgBmE1J+DqLqG9LwGJkB5J0IzFoHvgB',
    'Shantinagar':
        'BBS43nRq/kyBrgBpP3VO1HsHpErQ9N1NxI4N2CwXmLNgSwL9M4F7GyLyf+O0XiGoO7FsHtQlE9L4DpO',
    'Tulsipur':
        'BBgB+2nRignyBnGzVpO+FzXhG7dxNhF9II6clJ3B7X1e5M+TlFpL7GmIxJrHlL8kB5T0hBiSsQuEjKwLsJuDpNwS+BsNoiBkY1CmHqFyBwRwQuEuJtVyMpCMhQiVtSFzPkOvHqBpN',
  },
  'Darchula': {
    'Apihimal':
        'BBlB05pSwvrxBjZjGlG7W5XtN0P7VvCjT1d+GoCzMtEvDrTyRpGApGjNxSoFlMmgB8F4QnFlD7E0KmH+MoLxEGqE7Xy2BgCiWpNoLwEoU3DgHwJyPosBoI2HzS0ZQqPhIwN/QqTiN4JXuIhanE/OjK1H0R5sB',
    'Byas':
        'BBtByvuSgzuxB0IjZvF5H7ChhB7nBzlBja0IrH9TtL1E/E5TzUtQvErL5avI/D1R5Z7Z7BpS6F3LxHxVvSlNhO3BwV+djIqN7ciXxEgWmI+InC0MsetG6B0SzP8V6XuNmG8WkZyD1RkwBwNkQ5BohB4TqKiZyhBsTyK0IvGK1K6dmBoUvYoKtGmImHkGhKkID',
    'Duhun': 'BBK8/nSknnxBiPnI+FvO5UnbzTlJ/I2LlEgrBkHB0J2VoPtQ',
    'Lekam':
        'BBRwokS+vjxBjFxFwCzI/QhE6B3dtKkEpIoQjN8CtF7HpKG2M0ZLsdmW8S+HlD+DlQuNpGyFrP',
    'Mahakali':
        'BBYojnS05lxB0E3OvHvBtUhgB3N/EyGnkBlHzRzT5GUgN4FfkFgO7G4MD+U/G8HmEwKxImD2EsIjFyLqT6KP6NiOkU2W+KuF/CyD1nB',
    'Malikarjun':
        'BBUkxlSomjxBqEzEjF/N3FgBSzKhEpJjFOzBvMpOE7C6FrY8F7BodgRiE+C4f8GnI4VsgBmG9DlEvKkJ7OQpV',
    'Marma':
        'BBUw/lSw/qxBxLsClH9M8EzKoFmD7F3QmMlgB/UzGjb/lB5K0KmFgtB9OsjBiCoS8LmPmSgvBvIiWiMiIqNlL/BjW8X73B',
    'Naugad':
        'BBSgwnS+5nxBxJpXnM8B1W9KhOjUQ5NvTlKxIqEnKoXmL+lBtJ+E6WiiB2W0H6QnGsGkNqGAgTpQIla',
    'Shailyashikhar':
        'BBUgllS8klxBzCzP1S/b7GoINvSvF2QtNqGhF+RpLnEkLyZuKkJ+BwlB7FoL6DqO4HkF0KxK2IkEoFlFlL9lBqV/jB',
  },
  'Dhading': {
    'Benighat Rorang':
        'BBest/Qi11zBRhRhIzN3FiR1K3E3CgX9H7D3EiIzMjH1E+C5FkLgJyoBvQsY5KvG5M4IkNqS5Owf0Q8NqOzTBnJkYhN2CpHgY4I+L1E1GnFkG9H3F1VmG3GnOlU2QtnB',
    'Dhunibenshi':
        'BBOiu+Qy0g0BzFl+BxNwExC3HpJ7C5YF3IwSsHqY8VqFoHmP2F/EsFyhB4PzCoBxU',
    'Gajuri':
        'BBPii/Qkm7zByHLpMtQyG/KhEpZsEtSxdjI1CqHlZ0OxUu6BqNqXwanRkL1OgNxBoL4J',
    'Galchhi':
        'BBXs+/Qo16zBlF5KpRiOiByOxKnByCjDvMzGpLkChC6GriBgZJ+FujBuCHoKiJuDkEqPxK2UgIsJiLzbwM9G7ElS2OyGyFxKmF/yB',
    'Ganga Jamuna':
        'BBR+gmRmu7zB3VlEJxRtO/G/B3P8M3O1C1PpgBpNuDwPjF0fjO5C9NqUyG4Voa2NgQ2RiW9CsT/Z',
    'Jwalamukhi': 'BBJ2tiRgv4zBkB9M5L9bjhB9HvdyPwVq4B4V2DgW/GiItT',
    'Khaniyabas': 'BBMmylRk+8zBlMvTrRBnNxQlYtKPkmBkXkWuGohB8SiHoCpNoP9VOrS',
    'Netrawati':
        'BBOsujRgy7zBvI3c9FnChHkP1B5XvQkKxK0S8E0OpG0TyPwNsNsBwEpRwSrJJ9K',
    'Nilkhantha':
        'BBWs4iRyv5zBahU3JpL5JyS/VgH3V1DvI4PlL/EwDyJhO+Q6DqRpGisBuFI+E7K6QDkpByQ3C1NoGjO5EzLyKzSgQ1HoBxc',
    'Rubi Valley':
        'BBf6zpR2o+zBKtRvMlVrO1I7GqDtSpG/F5QlHvBkCrE9TtShOqH7QpHlKqR9S2L+O2StGsJoDyKnP+VpBuS4F2JkO4CwNkMqI8P4RgDgMxK6QsJoT1NyPhCoQ9KbjM4IlT',
    'Siddhalek':
        'BBR86gRyj5zB3U5uBrb6EX4TjG+H6GgF1KqHiFoZ3Hwa8EqKgFsBa1Iod9VuE/H1DpJ6L0E+IzR',
    'Thakre':
        'BBR4y+Qkm9zBjChS9InDDzKljBnCpFoUgF8E3JyCyNmf9KuPsb8ElBsGuJwBuOlOmDrL/HrJwI3R',
    'Tripurasundari':
        'BBP0nkR0l5zBlEzQ7QrH3UsBrDzN3SrMkHiNduOqLgLJ0mCiHjPyKqDgKhUkO6CyE/e',
  },
  'Dhankuta': {
    'Chaubise':
        'BBTq7uQo/s1BwGjH5KpP0D5JzK1MPpQhyBmGjLwZ0Jof/JqE4Dye7D+KsIN6IxJBrX4K+FsU5GsOuD4KvQ',
    'Chhathar Jorpati':
        'BBRy8wQshr1BmN/E/NhVmM1eveuIpByTtHuN/S+BpVrGhQ6IwHiMG6P6I+GgWuBiF1GiUtCgUlQ',
    'Dhankuta':
        'BBN+owQs3p1B1KxXxG+H5d/WpiB2G4F8F3EqI+GoEiJ2rB6P9HqVsGgT9BkIza',
    'Mahalaxmi':
        'BBN6hzQumq1B3E35B3NsG7JjCrK5P3SsWtLk2B8M4OqOoBkIwHqTpU+HgB8F3K',
    'Pakhribas':
        'BBQ20xQomo1BsGjFnGfnUphB7UjI9boM+C4P1OoKpEkUgY2WyG9H8K6R2GVwXvHgB9RkM9Q',
    'Sahidbhumi':
        'BBQ8xvQwzn1BjCxQrZ5XhNUnFjI9EmGhLJwH6ErLybiDsL4I6E1DicsftF2K2EjCpRwRvQ',
    'Sangurigadhi':
        'BBVsvuQiir1B7MvelDja3G5D4E/HhG1E4E7e3I5EhDrLsL1b7cHjJggB0JgL/HoOyFqZ9M6QnFscyMmO8CgSmKpI8qBnD',
  },
  'Dhanusha': {
    'Aurahi': 'BBJsjqQ0iw0BazV5OiFvGzHxKkgB0JP2C6K0K8BkIrT',
    'Bateshwor': 'BBLu1tQ4wu0BmDxHuJ5BhD3HtgBnL/DwNhWJ3C6F6JuK0K+BmfpD',
    'Bideha':
        'BBRi6pQg2w0BtJjB1C5KzJQqE/FpL/FjC9M3GrD3B6NgIsLvFgZjJoM8D0G6doD8BnNkH2CiDpV',
    'Chhireshwornath':
        'BBQmxtQwyv0BzQxEShMpJvMnMxD1IvKxBsN7H1ChEoI2C6InJcnI1H8BwMykBqQqc0C0HrI',
    'Dhanauji': 'BBKovpQyov0BhN7G2E5KhF9F7EO5CyPtJ1CgMyf6MuH2Fnc',
    'Dhanushadham':
        'BBWoyuQi3w0BtUzcrM0DtoBlI/FoR3N3FyGiHjF2E9HxC2M2Q3GkBqGsDhBgKtIiFmKgDkH5E6N+C6JrP8YpJ8OEmK2H2F1H',
    'Ganeshman Charnath':
        'BBXs3vQo0w0BKvOnR2DxRhEhN+HmMsHzHsKlMjI5jBoInLqQ1IS/GmJ2Gmd0fzO8OqBmL+LxcgrB0JgC0G8VoLrCofrqB6V92BuB/f',
    'Hansapur':
        'BBU6xrQwxw0BahEnI+C3MnJ8ChMjGlDyM5BnE9GlVpFpJmDc2U5JiVwE8FmMpE8C8HgP2BmCvGuG2BgC3IoJpC',
    'Janak Nandini': 'BBKs7oQ6wy0BpCnYhN5LhJ8f7N1BdiE6M+H0HzCqLqUqHzX',
    'Janakpurdham':
        'BBSwkrQi7t0BrUnQvT0IvOlE1QwUF0N0JwF1E6KoM8D+GwMsKnHqPS+H1PiIgBqC7GtH3C3DxQoO/G',
    'Kamala':
        'BBQ2uqQ08y0BqIlG9K9LhKrD9B4G5OGgD9K7Q5EIlL7L6C4D2azHgY+GoIscrCyWvLchG',
    'Laxminiya': 'BBN0jsQimu0BjBzE5X9E1U2G+D8PsHwBzBoGgITiLkLqFnCoB9QiIuC4BnO',
    'Mithila':
        'BBei8xQogu0B3BpI7SyWtMnBvJwG1LpIhBzK1HwHjMtJrexDrBsHlShDkD0HvJ+B7C2Hxf8C+KkOhC0KkSgGvHiJqUhBwN4QkO3G6M+EoR1DiE1WkhB7Q0HlLsS3DkF9O',
    'Mithila Bihari':
        'BBRgjsQ6mw0BgG9QxgBjN/BxLtPvB5H8PsOBqK6ItNwDiGoDxC6M8O6IoCxG0HgDmF1EzG/G4NwF',
    'Mukhiyapatti Musaharmiya': 'BBI6noQ8ot0BvNtPzP0DjNtF4Z+wBmGpF5B9NiMpM',
    'Nagarain': 'BBJqkpQ07t0BtIhGpJoF9MzPzLuNR4c0gByLuD1d4GxH',
    'Sabaila':
        'BBW+ksQ2zy0BmCjP7GpHmIlN9WnBuIhFiB/JrGtD6GhBxEzEtOpC/B4ItGzBlCuGhOvCtE0QoZuL8BkHpG8FuD+IwWsFsKlD',
    'Shahidnagar':
        'BBUslrQyjy0BrB5I1Y3KyE1O9D/I9GbzBkHpJxIpDgWjH1C7BoNjKtDHmL8Q6EtCkLoOLwGhGuQ0OyMhFA1N',
  },
  'Dolakha': {
    'Baitedhar': 'BBJw58Qyjy0BnLzStiBlMvX6jBgcsc8T+D4BlLiH3CuMnX',
    'Bhimeshwor':
        'BBPi89Q88v0BvFlVoEjK3UtP7Y4B9B6HpK6D0OuWjc6dpJuVmd0HoMuLiJ7V0S1L4M1Z',
    'Bigu':
        'BBjBsylRmxz0B2V7EtBxH9QQ9KxWlQrHvF3HiEhQhE1FtSsH9ZzJzWkP1RmC7NgMjOrlBhb/OvX/YnN8KiG2XhN0MhJwf5dgXsPkUodgRguBtB2O6iBkIdsb2O+K/GpDjgB+E1G2ffghBjNuIuLwYjP',
    'Gaurishankar':
        'BBqBy7hRmq20ByK1C3KpKkI3Lrb1OjIe1O5iB/tBuBnd/Q9R5WtSvLhGnMtL0LlDyMhH4C+GqzBwRmHmE0XwGsNyL8GMgN6U+EyCshB0JsGkDjHqO0F2K4O5C+Q5KmKgB4iB+8B4HiOpEoH5IpBnHsKhEvG7chKKnPlRS5TyTrSF7UsG/E',
    'Jiri':
        'BBZwt+Qi030B1Dhe5U9EL/MxL7GvGrNlEzXvRlHuBlPzJzYrUnE/E1JvN3G5LsI1HwNsLqK4S87B0tBsZ0G+Hf+OqNqO6D4P6KgC+FrK6P5B',
    'Kalinchowk':
        'BBOgq/Qq7w0BtF9YzO8DlI9D7J+I1K5DnKyPhSkLpJkWqO+W6UgOwclVsKphBwKjK',
    'Melung': 'BBNin7Qohx0B5DlU/FgIxHvErIqD6FvQpMpZrJoMjV7H1E+hC+a5HqdkBiLtI',
    'Shailung':
        'BBR6u8Q4yv0BE3H/NvPsMhGxDtSzQ9EpPlQ1OmqBpUgSqMqZ5FwQsIpDyHwEgG/HuE8Z4LlX+a1c',
    'Tamakoshi': 'BBJgq7Qulx0B//BsG1WuSyNsQscmKiNyRsTzVnI1QuUpe',
  },
  'Dolpa': {
    'Chharka Tangsong':
        'BBjCkh7Ru09yB3WxnB9F1enG/E0J7enYlLjQmZtFVjChKjelE5KmHzZ7IrF9ZkHpkBgRe8OzHzW3RrMrUpV9CpT5MxRjW5NgDmCwOrNwkBxDifjhBxGzV0GtX3NxJgoB6GkMhN4dgKwerC2WiSyQvB2N8N0tBsiB9BmFuNuTtBoqBglBiHqNmRyHjC4K2EyDkevB8OsEoDuHiKPoK1J8FyItBkNuMuGT0M+P7C8EhIyI2ByDjFhL/O+NvOhEvM4D5IiO5CAnU4InKvJlQkPlHiH3d',
    'Dolpo Buddha':
        'BBgC4whSwq6yBxG9XvlBnmB/J3XrKuRvXsJliBmtBlQgI5NlYwEjNtN/B9NvL1WuG1GrG3GpW6I/ctOsEtG9JjmBsLjfnlBxP+N7E6SvP2UyOoO7O0H/QdjHqkBsF+ZwWqIqMtGqT+ByMkCgCgKuFWkQlZoYmLzJ8eoGgF+F2egXqmBpHkfjPoHwJkQuY/E0FvOyJ3CvD3NsV5Q2TmE4L1SqNhC2C6GkLmCwLtH6E5auNnD8J7OkSqB6I9RrGhVuFjJ6exHtB0LmFoG',
    'Jagadulla':
        'BBtB8s+RisvyB6LnG7JrG/QpciInLwQNnItoBtTvGpJwMtRmE3G4J5OG/JjVpNhD5JlN7D6FvE5DnPoHvN6W1GpC3O/nB0Era1DhQ1L1H1hB4xB+E+GdqZrPiV8H6N7QyawbuByEmT0N2F0HshBwhBqGsVpPwHgbwV7I8KkOkO/D+P7Q6XqLyE3OqMtLmE3T',
    'Kaike':
        'BBiB6q4Rgg2yBjIhMlQQlIhGlS2DvC5ZqG9LpFlEtT0CtB1HzX1IpEBMgJzW5DpcyGnNnH/U4WuBwL/OysB8D6GzawVoCkUyX6NyVzGkhByG8Q51CyO0C2OoUkUqNwUuCiU+X8P3U8E5S8N5M',
    'Mudkechula':
        'BBTgk5R2/pyBxD5Jv2BxG7RnInJkElIqkB0PyRHyY9UorBjDoY2RnLuKiB6T8d8Qxa7H5NsPhVepZ9E9GuhB3yB',
    'Shey Phoksundo':
        'BBtCqmkS6uzyBvN9iBqD/UvZB9KtUjtBwP9E9JlXvNlEjf1RlFjIiHzdvU/awxB5XpL9KqN5QqHlN7NvV8IvH/arVqPnoB5EvNgI9BuQtT2L9F2sB3N6H8Hkb+KoB+PuMuF0Q3Ggaqf4e0EqLqmBlLuG+JuOrE5Igd4GqW2GsG2WtG+NwLuNgCvEkN0NkYsQ9HmiBltBwXrJmKvRmK6XwlBomB4G0XiF/DEnSmH9KiKoCyDrNrLtKmChNmM4D+ErJ1D1L0G9GxHrC3CtQ5F5CwElKiKtCgD5N0OlGnC5H2N3H/EhFrB3bsHvJmLuEsI5HOzL',
    'Thulibheri':
        'BBmBgu4Rsg1yBzFvRxajNpH3alSDpYpS6DpS6N/UzPta9EtF5KmGvUxHjMhbwBpJ9H7FvDyFrM3BhLuc9WyO6J+JnCgL2GkLtBkxC8IrCoI2GucxG0W8DR/IsEA0X2IuB2HuTzCqFoEtG2NgFoZ6P9E6b6H8HpV',
    'Tripurasundari':
        'BBa4h5RuswyBlGphBzN1FlE3S1c5B/S9d3KdtNwMvCnMzJgQKiQ5c2M3M8N6M6e8U6H6KjGsI8JoMgW5NgV7DoSod8ToZrHkH7uB0T9L4BlQ2SxJ',
  },
  'Doti': {
    'Aadarsha':
        'BBYix+R41rxBpFnR9GgFtM7F8CzJnK7MEhZ5E1GpN8d3JtFjIwFyIoUtXkXkKkVEySqKkL6IK1CtRiIjDiI2J4JxRiIqBwFvN2QrL',
    'Badi Kedar':
        'BBiBs84R4xrxBJpLpRhYpH+FpMlClO3PmGzIjJrI8DjVlWExFuQ5IA5GsWpcoLmDyJ0Z2OlHiR5NhB/FqIkF8BpH2I6HuK3C0fgSiH2KnHoX+M8LrFmOkIkJ7f5BzT+M9FgGnPiIJkFjI',
    'Bogatan':
        'BBd6v5RqlvxBlFrYxUnO+J1kB7H9gB7IoBjGsP9M+F6B0ThJ8fnOjI7LsFnX9M1KoH/RhHqLsP1C+K+P4RhJugB2I0C+ByQ4PuLqStD2SvOgKwEoC1LmIPuXtb+NtE',
    'Dipayal Silgadhi':
        'BBc098R08txBHzL9MuI9NpRgHhJjBnTjKjVqP3RvN9CkCwI7L6FLwKnUqM4E6KjCmDlC7E5HwL6I8L3kBgsBqVpC+c8Q+DzXqMwEmElHsKSAtHoL2B6C3F',
    'Jorayal':
        'BBbgl6R2noxB1IjkB6BrQ5GpN7NtE3C3PrPMnIhZ5J+ClagpB0G0M5U+TtLgtB6E8LuVS3F2R0IgGzF4LiG6I8TkJ8H9FsSihB2M5C+GrISxcyRvXiCpoB',
    'K.I. Singh':
        'BBQui7R6ntxBjIhM4HtLpH+G9JzJ3YvE3YpTlHoD8H+gB9J2kByUoOqFgWoQxFZtO8EO0d1nB',
    'Purbichouki':
        'BBUui9R6hvxB1HlfnK5BhB0HrKRlEmHrNxD7C0W7c5Q1MqB8BwWqPwcuIiD+G1K2IuB4X+MuDsJsLzeuL/HFvM',
    'Sayal':
        'BBbg0+Ry0sxBwP5K/R1UjRkMvFwNhIpB3JyRhI1JhIkD2CuR5IJ1IxKlFiEtCkFiIgGSoI8FiDsNhHlEyb4IoQiU3OkF8NkTuBiFhV1K1SlE7bqOjG',
    'Shikhar':
        'BBiB6n9RgypxBsInFvTpCvK4KxItCsEjKrG5N7OgGxEkI/NhLzIlUhYrB1CkoBnVglBmD6OrVoRojB+WkSmBoK2JsHhHkC+EyCvHrFxGoUpMMvK8L5F1CpI6Q0DsFnGxInUkIvF4JuFiKhQrBrI',
  },
  'Gorkha': {
    'Aarughat':
        'BBTw4mRim7zB7RrbOvPzJjIwDjS9HhnBrbYvI5PpalGnG4pBqwBqVsC0P5MsOkCiQqO2GCsRoSM0UuJ0G/M',
    'Ajirkot':
        'BBR08pRko2zB3K5R/L5G1SvH9RkD1VzLxQuE5bhUhF4UzT2CvGkN+TmS06BqZmOf8JvIozB2I2CvW',
    'Bhimsen':
        'BBU6hkRw/1zBD9PtGzGjGsLC8TlKwCVpFlU1EtNkY1RuJkM+D+G+R0Q0JkDoNma5Cf7eyF5JtEyBxB/F4Kjf',
    'Chumanubri':
        'BB6ByxxRgwzzBtEjiBjQ5MnMgM3C8L/MzEvGgGjHjCrP+OrtBgD5CuHhZ+GtOzDlGuLzP2J5HiY1nB4YzNqUmEqX2J8FjGgIxF+/BlRuXkLuE4KqjBoW+YwH3I2jBSlI++B+R8LkDwV+ZoIsBgN4V8C4RlL2EyJ0N2FiLvKd/Osbta7JrT+F7SlqBxoBlIwCxFvG1G9UkJvCftbjOtbqY3vB0EtbmMna2VqG2H7WkavPiH3KbjiB0JpJ',
    'Dharche':
        'BBjBgjsR4n8zB/kBjEvH4InW9Y3KpjBjLrEmRvXyF9/BkG/H3DrElnBSviBqO9ZanK+JlYoGAorB0JkINwP6RqanGoP4O/G+TuSjCsEmHwBgG6QuSqG8GpDsO2IwMmVOkRmc2L4K3GuVdmM3N2Ft2B',
    'Gandaki': 'BBNgvhR662zBpGtKpBpW9czavMoRrT4ErOonBmO8T/FyGoD6FktB3U6DnIqW/E',
    'Gorkha':
        'BBS06jRmq1zB5N/kBhtBpf6BzZ5NtQ7H2UzElDoB+W/HyEyX+HiJoM/EwtB0VB8I4NxCqIwX+K0FnDqFzd',
    'Palungtar':
        'BBR8zkRm/xzB/QmF/GhNxdzFhLrSnKxFlL0EnBsQjI+MgMkNmDsbhEiBsGoJ6kByTmQxO4QhFkI1uB',
    'Shahid Lakhan':
        'BBVs4iR+91zBoC3F7I3NzVCyF/qBzJ3O/LNvQ1KlNI3DqHnEjDjC4N0MqNlF8KwFgJ3GuG+c0a4HgmB8HmC2RtJ0Pza',
    'Siranchowk':
        'BBPo9lR8x0zBpTniBvPtJrHzSlImc9P4DvPwO1H7DoO6N2Iwc4OoHiYkEgFvM0T1CgDtS',
    'Sulikot':
        'BBWy9pRgp3zB+FhB5FrBhBrJhN4C9oBvJ7JwIrUZt0BvX1WrUvgBpIoGwS9KyoB6c2F4I+PsbXuE+NmYnGoK9J+ZZwiBpOghBM',
  },
  'Gulmi': {
    'Chandrakot':
        'BBUsimRy38yB9C1iB1DoI9W2F3IxSnXwMxI2LzC8K2N8JmKhE4GkR3JyVmHmKpImLgD+L8N7DkI9RiHuClDniBiY5T',
    'Chhatrakot':
        'BBRk7jRsr8yBapNhHpH1S8DO1J/J3KjQ3B9QpQ1J1BtCwiB+T0L8CsO5F0LqpB/N0CmT8I0E4JzY',
    'Dhurkot':
        'BBUqqmR0n3yBhGxG5f6P7E9hBnInBH+S5KoCwEuOtJB/F2PsRuUpJkLmRaQ6F8NxFpCrLuMxEjFvK2S1JwJ3U',
    'Gulmi Durbar':
        'BBU00kR6z7yB4P1EnUhJzB5PtKtE7MwFlCpHjLC5G1G/HgD5EpFxOkLC4R8QoCgK4KN2J2S7DiHqHf+J0Z3T',
    'Isma':
        'BBW0tnRgi5yBlFhJ7OgDzH1G5NYjG3EgDzQ7E9BjOsIgF2KrMuEwCmL5N8H5D0JsM8BtI8I6GgIuIP+vBhO+HrHI7Q0KqD',
    'Kali Gandaki':
        'BBR8qlRqi/yB7GnLzTgK7HpR7JAha6mB3JvFrN0JvBoR2UqRyQ5QkBxK8RLmIsMyJpLuPtFsF3a',
    'Madane':
        'BBT+znR8k2yBlFnU3TwJ3R3E7D+H5GpD5HwM7CzEzIgGvJhFqBktBmUlL2FgEqHzHiG8CN6M4NzQ0LmKyQhlB',
    'Malika':
        'BBRo9nR2r4yBgIxH9MtP4E/DPnTvO7JhHoU7SpG5W+cmBuT2agKoP9CmF0IuMBIjQ6KmF9H1K',
    'Musikot':
        'BBVshoRy54yBhHlIb2QzWnDF6Q/HuHn2ByM3IiOkLyHIiTxLqI+G4NsZnF2DnI8Cqe+R1NsDjGtFzPuFrNrGrUgwBj0B',
    'Resunga':
        'BBXqnlRoo7yBTnPhLpHyIvL1InJ0ItHzMvCoIlMlFvF7SDrNqRnRsC5V0MwH4K0KtCwEoGoLAiCoH8MvF2KyE0C6QyS+HqD3G',
    'Ruru':
        'BBQuojRgy9yB6IzN7IzEzClTpKFtE6H5K9BzNkJ9E1C3IwKyFgL5CmIoX4U+I9IyG4B6N1R',
    'Satyawoti':
        'BBR0zkRix9yB0E5GtG5QvK4D1N7JtW0oBjXgL0E4LnLsW0EoP4QnH4JwFia5mB4RiDsF3InHhKiFxO',
  },
  'Humla': {
    'Adanchuli':
        'BBQ+zlSmy9xB7B/MzatB34BkpB7NpGVwPseyX1C8Q2IiIlCsIkYxLM3KoIxJrB5KqUjK+N5nB',
    'Chankheli':
        'BB6BgtrSgrmyBvGxIIhlBxYigBnQkJvH3BpL5QtL9BhavyCrMmErLjGqCrZ9TiJ1K3HrE5OrNzHrIgLpN3MrKuZN6QjLSxSiUzU2E9HiIpL5G0OshBjD2W+Fka0XzBuB0SxG4MuMwToCyQ/LmhB+KwLmLgCmSvKsKyJoRtH4FgX8M7EgQmD8CoRyOrJsG0M+M6BoOuQqOtOoFsByJvb8V7WyBlMvJmBPpJ4WhSzFnWyO3K6IzW',
    'Kharpunath':
        'BB1Bw4wSszjyBAhFtsBxRpRlQjUZ9KrP3egRxbqC3JpJ3lBvJ7iB1bxN3YwCzfvDxQvGjE2JnZ9VnIpHlK7FgMviBtE/LyK8B4KrM0Z0ImdiL2LkS9G2VoZzG0FoBoRpMqOvDoesLmGuMlE+ZqyCgMuCoL6QsXzHsf1jB2V2M+G5J8IuRiLoEuE1O2SwBfhQgGnM0QlHKrLoI7GqMqMuLtF2P6LydzO',
    'Namkha':
        'BBxC00ySso6xBAnFtNwCzHtJ+J3c7MZ/CtFxUUmH9mB0V5boDjXxPxE/H8R/H3FzBvPnJ2GzS/FtL6QvHrNlHtBC0K7MjFxGnK/Z4CpTzcxPxLXxJ2HtHhLtenVuV5XRnShL1Vm1BjCyP4JkM/Q0mB9TwDjJ7JxRkGrM9DhH+I8B6UmHiIwLCyQuqD8HlBMwJ6a+M2DwYuK/G+FuFiM1D2IrLwD0TnP2JlItB5GmP5N2L2EsOwTsSuQ8G2BkSmK+HuPjDsN5NgoB/GkK9HsJ4LgH1F0TcuJpJgX8JwO3O+M6IoGrO1CpSyHvKelkB+FjMkIhD0Vx+B',
    'Sarkegad':
        'BBeijoSi8gyB3VlbjS+GhL1LzIldsMzZ7B3KgMvKvEjH1ZvEhKgH3P2uBpUkKsB6KnIyJL4KjYyL6SweqOqIoMgRuKrZqN4MsI/KsN0HsE6O2K4H4U9J0MrShB5RoGhD',
    'Simkot':
        'BB7Bm/wSqp/xBoBtHtI7ErQgPlVlKtJqJzTb/G2FrJ3LjK+H/nBgHrN6NtPkDlK9H1BjShRpH7S9R1ErO6N1L6GlPmIuBoP1JxD3TxIuLjM4D9FtFtKgH1DvY5a9M3DlKrd6TgBgoBqHmKsWqJjKmYuGiEyD0QpD2bgF2OmsB0pB6lByJwH2I6d1B4e/Q+KsPkUaqRmQusByR+F/GtBlLjPlHgHtZlJ/BnF1O6M9T+FuDkFhIlHnHiIvhB',
    'Tanjakot':
        'BBOggmSgj9xB7D5TpkB7HzhBxS/XqBpWuYHiWuNmKnE6X8NqGs2BroBwXjB6JoI0JtI',
  },
  'Ilam': {
    'Chulachuli':
        'BBag0sQo8v1BiEvBrDhdtd2mBrKtDtKwO9MhKpF4H4CoJ/lByKlTmkBWiQ6IyBuIwPkJjJuWhGP1SnJ3JsFzWiK3CqChJyP2FkEhMwIvEgPiIsV5Y',
    'Deumai':
        'BBZwnwQo2z1BxR9kBnWyUxLJtF3KpZjU/NqJtcnI5K+EAkLvHC0GsLlF2SgD2MgPW+IxHqMwKsWhB4CoMvFkP2WnF2FhQqPpQ8MqF+Z9J',
    'Fakfokathum':
        'BBO43vQy6x1BxcnkBjOhInOkSnE1HxHkCkKooB3H0DqZkUuF4K+XjG8JjO5CpMyE3J',
    'Ilam':
        'BBjB6xwQ69z1BrIjJ9byL7MpFpPqQ1FiQ5VqF0ElPpDtM5VoBpMtK9IwH/OV7EgNqMqO8RgF5DoCkC6JkFvB7D4IqHsJlJ2WwH2I8MnGyCrHvFjY6oBvCgMkMmKSyL3V1LCZzLqS3MkLc6QjY',
    'Mai':
        'BBcq2sQkl11BzY9LvFxJkH3rB1G/LwHBUxH3LrR3E2HhP1GxImPxpByRnPyW3BmOwMP1E0HiIkctFgG+SvDgG4NsN0E0KxGUmG+OwDoT/GgD3G2LqKoLhY',
    'Mai Jogmai': 'BBMmhwQ8n41BjFlbzKhF/F9jBjRZ/LjM5oBwC6UshCmfduD0KiO6LiW/H',
    'Mangsebung':
        'BBW27tQ2ky1BlH3nB7T7HxIpazZ0a/OhIvIwEjEiM3PxFjC+IhK4CrFuWoJ+JwByPsM7EyIlPiP2G4E1H+J2PwO9G+ZsIkUnL',
    'Rong':
        'BBhBstsQgl31BoJ7IxPqCrfxc9HbS8JhQsBY4JwQ2EhImCgH6LpHBnNyM8c4MlFmGsLwJ5Y4C9JoJmUsM7HgDsC0F4WqD9N2JF6LiV3DiJzMsHB9DrG2ExP1M1F4EtRsJlFiCxjB',
    'Sandakpur':
        'BBUssxQ2711BxHhlB/S/VvO4LpC8JjLbpS4Ma0L4LDzMwW+HNkGqkBwK2EjB6H0FyCqK7NoOjH2IiDwIrI+BzgB',
    'Suryodaya':
        'BBgB6tvQyx41B7QnNtDzKlfepPnpB5CyHzN8FtGtIkJxWpHxJ0DlJtOiQ7LnK/C4GzVgHugB6d2PhCvJ6IhCyjBrJmF1E4Q0MsG1EyP+DsGrHCrD2I6aF0SrW+NgGsS/PyVuJmM7a',
  },
  'Jajarkot': {
    'Barekot':
        'BBeo54RwjnyBLlM9IlBxBnX3GhBhDnO3JxBlHlL2ElInNpM3JV9PnSzV0azU+I1KuTvRwGzB+JjG6BnH4jB9P0C8B8WyN6B8LuPyGgakQIiV/I01C+OkNjlBhEhTmHvX',
    'Bheri':
        'BBbujyRw2lyBiRrIxBpExVjKnF/MnLvD5G9b3RpRnXlEzSwKxE3LzHmJmFmkBxGqB1C6PwK6NqiBqExEwH6W+XzLkU0HpCoFoFmDjI0KnB+Mjf2NBOpE',
    'Chhedagad':
        'BBiBq9zRyziyBjF5TveoD3S/GyGtZ5DlUvDvErFkE0C7SpL5RnJnChWggBtFyvBvOnDjVqWhFnBmE4MjGnB7CyIyE4L0SvKiXiE+RuR6G+b6N6GsC5IkT1DzE5UrIxI6N3I2B3JkGmJsLpMkZzC',
    'Junichande':
        'BBYs42RgkiyB4HrNpJpE5Sta/EhY/gB+ChPjTpgB1JvX6GlWkSDkP+HhC4E0WtG0Z0S6GwenDqF0U6TgO8JkE2V1I+IiFsHlS+N/CoJxJ',
    'Kuse':
        'BBYyp2RmhkyBlOpcvKhH7V2IldhSzZiCrLqMjGlJ1B4J5N2IsI0I0E6UjT2DnC4P8NqE8MgNqUyBqZ4UiG1B0BhKyRtGmM5UkTxH4NvU',
    'Nalagad':
        'BBkBo32R6nryBzQ3XmI7kBzgB7GpE8F/b+CxG/Z7LtP5ME1C5YgQzCoH3jBphBzW3TKlL2M1NElJ6brOyElDkIwauDqD/DqO6GqEynBof2a8FiT6NuPnD6J6GsQ8JqGwQ9B6FqHiM3B0XmY2B0RiN9b2ChY',
    'Shivalaya': 'BBLkuxRwo/xBnD9crKjKlTsYhfiQ1EqnB2Dk6B0X9XwOqDuFzvBkVte',
  },
  'Jhapa': {
    'Arjundhara':
        'BBb2/qQih21BgIazN3ETlGzKyGvN1EnBlJ5IxF7asMpKpEzH0DwBiMqG8CjCymB8QqH8QlD2F/bkOoP+P+HuKxBzGjMiInCvQzEX7F4D1FqMOT1J',
    'Barhadashi':
        'BBV00nQw001BlSgHplBlBrG2IpW/E3F2J1INI2PgHxEkNmKqMIgI4JS/L6JtBd/IoMamImS6GnG0IoD0NxZhB7R',
    'Bhadrapur':
        'BBWs7nQol41BxM5RjGyD3F5Ghc+JlNrFtQ+IHtGxR7L8D6PvO0CrDwR4F8EoM5CyHyJkTpFgBlFmH+H6L/C0EoIkanIyRxP',
    'Birtamod':
        'BBRkzoQm421BpGzbtX9JlL0M5KrCxDwG1HfgE4S0OkBdmQ9H8K6K2FwJBqMhKyQMhB9R2EhD',
    'Buddhashanti':
        'BBU2rrQs041B4C1D7KxIoFjG9c5M0LlLlSzH3N/OzF8bjLwBZ6Z4XHgB6IjckNwT8EsG1FhCkEsFaqW/PoVA',
    'Damak': 'BBMykqQu7w1BmK/GrMxF/IxOxmBtI7X2ItQnKmIqS0TiJgQwRuK4D4jBnL',
    'Gauradaha':
        'BBZgioQwpx1BN7FjW3IclKlG7EkHhLrIvMzTsGhahCvX6KJ2MkR2D3MyK0FmJJuXvE0E3C9D+JoWyLxHuQgBsGlHAvToJmEoSxQmYkB',
    'Gauriganj':
        'BBbwkmQ64y1BjFhK/O8BtC4F5FvHpGnP4C+DuErEcnUjGzM4MxKjR1DwC5JnInEvGuJtIwBxFuWnJqHX2byG2F8RvB8K6H3D2P6Q6LqH7EmOmDuDnT',
    'Haldibari':
        'BBX6mnQq221B1OjB/D5SoEjClHnPhNbegJ5JuBNgMjI3JnTtFxByLpL8HoIoMhEyByEsV2NoJDsG6Q7ImNsF4WlGmIvNc5P',
    'Jhapa':
        'BBZyqnQ8n01B5O7CvBjOhLTzIhJ7TlElH8E5Q5LpHsLnGbpC4M4HgImJhCiIkRsG0BvMuPwHtEyRgG6JrJ0EyEmMtFiR4CE3LmGB6BxH',
    'Kachanakawal':
        'BBa6+kQ+311B1G5F7F6EH1P6L1DpL9KpB6PnJhF3IiH5PooBpOQpFgJsCwO+Q2CgKmXsQ2KmDnR4O/ClF9EoB1KmEiD7E5VkEjBpI1MqL7Hc9K',
    'Kamal':
        'BBY+rpQylx1B2BzD7MgFvLpE9O9QzThJlJ/R4DkKjHiLmG8EbmKkW4IWuFzYZrS0QhJpEJmU1PuKsSsC2WrQghBuCmSyNVhQmSnf',
    'Kankai':
        'BBR+tpQ0o11BhIlc/F6CrhB5Q9JTlCyI5GN1B0IpHmBY8H2TnDhG+d6LyGmLyDkKpKuKqEkRlN',
    'Mechinagar':
        'BBd0xrQk351B3WvErCzF8H/ClUrMhWwHvT7E8b3MSnGjM5F9MkDc9Y3RhBxDtFzYmEhHwL0JsIvCoF7iB+T2JqCY0KoRFqPyH4GyLsnBkEqYiM8bdI7L0NjI',
    'Shivasatakshi':
        'BBSurpQ2kz1BlI9N9QjEnJzKjiB5C/TuP7NPhEiYkSgMkHpBsDkPqUY0C9I4JUmiB+QkK5J7MrB0Nrf',
  },
  'Jumla': {
    'Chandannath': 'BBMmt9RsqkyB8CzJ5PqClElMjWhNrSkL/I6RpC9ExD0DIiiB0fkSwoBhvB',
    'Guthichaur':
        'BBf++7RwqmyB0IpOxiBzUlR6V1OoC3FmLlNB3E+RhHjC9Q8JsC8JhGyNiEqShNilBsZsD6B4KyLwHyEyiCuE2LkL0GgO3W8Y/IxGtI2B5fnHrMqD9OxFvakK/QiVnOhI5d2LjY',
    'Hima':
        'BBPuh9R4rgyBnL1T1exR9FnU3L8B3L4LtHsU5H6F2kB8pByL2mBuNrMJnV0RhD7CrG+JpS',
    'Kanaka Sundari':
        'BBWg7/RoxiyBxNrWkHjFA7Q9QnJlChSperD6GySjTsV7JshBgRyQoBgP5bumBwBkLgb5GmR6DkI9RmTpB0GhIrHzQ6OzLMzT',
    'Patarasi':
        'BBmBsqgSs/nyBzIxRxJwD3W3HlC5hBvG/KvNnFJhTmG5GlR3DtWmIrH/JxdyhBqDsDzUgmBiI2dlZuS1GwToG6TpD+OoHsM1B+f4F2BiGgR0Q0FgKkV6OF4G3JuRlEqJvMuTuG2Fpc0tB1Krf1nB+EpNufxP9GlO2K3V',
    'Sinja':
        'BBU+p+R44gyB5GxSpZhDrIsDtB6PhJoJ8CsGzRiDKoVtNuMmD4V6duWmEmMmU/EyKxOhBtP/QxQWhGmJpbyS7U',
    'Tatopani':
        'BBpBo+7RwujyB2H1E1HrJgBjO7J3L/SxF7UwD9H+TrN6Btc3c3hB/DvaJhLqRnTmGrHoS4P8buM1CqLwR4JWmNoMzEoImHmL4JyBa4L2J0FcmVoEsE2EnD4DyI6QjD4E9R8NHiF7K2OnCsJ9J4H9LHhiByDzDqC+EgJ5RwK3F',
    'Tila':
        'BBPo67Rw/hyB3KxbjZ7frd9T3J0F7EmZzMuCxV4pByTsCuc2csN3B+H9T8UvD+W+Ha/I',
  },
  'Kailali': {
    'Bardagoriya':
        'BBQktxRulvxBsLtClN1RvYtB9EuE7FtP9be7PpH0F4Q3GmCsF8EpB+OyJ7CuYkPwSqBiYhN',
    'Bhajani':
        'BBf+zuRu8sxBpHjXpM5F3EwHrIjK9H2JrNqDxXvFpM8HsGXrGiK4GwHhGrG9BgMhFE6EyRzGrJtG8IkFX6F8XkO8S8JzD8JoE4InJ1C9I4QoI7Erb0b0DgE5F4B+DoIhe',
    'Chure':
        'BBoB6z3R2xlxB4D/CjL9J3WjGjGvK9aoHeyJ5GY/C6HqGiRzFiDqDwKvItB3P8oBvW4C/H3FvByHjLnC9egS6DmI7JwX0ToMc4H5J8EoJsPgsBiZqIjFkIoHoP9C0EjNtJvMsIjHkRtBsKla2IIyKj9BsHnPiRlO9GrLgJjU',
    'Dhangadhi':
        'BBzB2gyRgsmxB0FlBzMtSQ3XpI+DoBuHjKtLnJiNhH/G6C/FnMwCtK6dvLrGrD8KjF7E8CqKjIqDuC2S5FkGgFmKtNwHhKrBRuLlKrD/LoPwCgXgF8CyLhRoIrFmJ0D+D7FoOgFsMvF9CgV0G+C2Y5JTnEsH4BK3FqP4BuMnOrNlOmK/H5JmBrEtMtLoEvC7MqY5B4C8GgI5HzE/P',
    'Gauriganga':
        'BBsBo3zR+0nxBjHtPpfhIwCiHjH+GpLrI1DkKjLhCkCyI6JlBlKgIoNwMhC4HnKmIhKpD3FuH5T6E3DgQ0IqCvIgZ3Q8G9J7JnKsfwNsF2N1EyI2DqCxF8N+OwNRG8L0pBvHoK5P7Q5B7SrU2KvRoSgFlFlG8J9EpDrLnRxI8JvX7DjI2SpNmXtF',
    'Ghodaghodi':
        'BBaslzR8gtxBhHzmBj0BsGF7LvNS7N9OpCyFxI1DzQwEvStHrF1N7IkM1EvITy1B2JiKhL0RLwQ0OxDkSsM+bd8FuP4YvGmNgDuNpJ6PqKoU3wB',
    'Godawari':
        'BBjB+q2R+0kxBW1V3M+BjYzM9KyahpB9IvOiHL2GtKxE3WoYvI/GP4X0MuSlJ8B2HyP9HuHpC3G9QlC1H6DuC+MqLpE8MmGqEpKqLsIkH9GvChHqfiI4Q6Q0W3C4P7oBwIuBlBnmBgHdV3J4VvG',
    'Janaki':
        'BBSs7uRgizxB3PzwBmL9ezB5U/FjC7EnR3KI/LtItBkEnP/LuCklBkEiFiDjI4JwEd2cpSkMwiBmpB6VyP',
    'Joshipur':
        'BBTqgvRm8txBlSjD5C+DvB/F9D4F1bxDuF8ZtCmD7O/JQ2OohB0P+JDwErGmP8BmDlM5FpI4GlC7FpOsEzE',
    'Kailari':
        'BBjBu1wRm1pxBhIpFGhNtO2B8ClVrMwFtJ5E1I0FvJvDxTsW1F9DnDsL9JgB9DwM9LLpCyQ1PiS3DoNkJvCwD+InHyToVgB0KhLsIkK4EvHkMqFsB7pByE6I8IjMsF0N+HqCoKrf6J8J8M1B6L3a',
    'Lamki Chuha':
        'BBP4kxR2ixxBxLhLwJtQ3NxU5TjBtYjPlf+D6NsmBxLolBsSg3B2T2LuIpT5BrO8L/FqgBlqB',
    'Mohanyal':
        'BBmCu51R0trxBkFjInNvKhHahEyMtO0ChIlHnIiFjsBhZhIrLnRCvHoP2S4T8Q6BnK6PuOmE5D8GqH6f5OiW7F4X5PpKtNqJhP5B4ToUtjBwP0NuUvJuQyLiLtgBoqB7LgG6BsOxIuTsc9DgGpJ6N+DqCtK+JkDuJ1I2LK2JzN6JkK2DzHuJqB0LjQwHBZtExRrC7EmHpFhCsLpS7ClN4I+C+R9I7E9IvI9BpE3OqLnIoBlKuHLC/M2fvb0IhYvDpJwEpSvHrIqH1IjF7BgGpI6NiB0B9J',
    'Tikapur':
        'BBau1tRuiwxBxCxGzCkE3D3DjCkIhFhFnF/jBlb4CjMlOmD3ChOhEhE+DoEuGzG0CxHzK1K4JkJyB3LoU0J5E4RsQ0LgD6CwLyZqgBuMyE+SvMAna',
  },
  'Kalikot': {
    'Kalika': 'BBKq64R805xBlB3GrQrKnavCzMifoI4KjE6MiG2YmkBa4Jj8B',
    'Khandachakra':
        'BBVqn6R016xBmK/MhGvHtVzChNrSlSJwF4I3O8rCqE2QqMgOgMlEyHpK4Q6CxGzQ4DzF0KgB4BjGjQhZiBtJuKkGHxE',
    'Mahawai':
        'BBd8v4R2nhyBIvGvdQjEtJ2KjOmB3N+IjBzGzV8GzZiJ9EkD/WnGpTqIzLxB3flkBZxS6PjGkW0FwMxD6OnFjB5MkQ3HoSToP2JiXzFqH+EmXwbqhBgnBuDqJvU',
    'Naraharinath':
        'BBQ8x8Rmn4xBJ5I7VhP5E5JrGuOnOoFrIlI5gBQnNsHUgQ9J0G1G8SmUuP6LpGupB1CysBvhB',
    'Pachal Jharana':
        'BBTyi9Ru08xBxOlvBpcoB7F3E5KuKvVxjBzJgT9KhGb4K+P4X/BoGrKjBnDqJsXmzBsRvK2BhM0U8BmJ3Q+dK',
    'Palata':
        'BBU8s/Rkz+xBtEpapoBxKgC5M5RnM1rBd3EqNhZwB1BkM3P4KqOie4PlFiE2T2eyR6GqOsgB1DihBiE2D5c2KhLB9K',
    'Raskot': 'BBO018Rk36xB+H7EvK1PxG8E7FlFnCmLlV1UvHqK7TiKmTif6KtK8F4EybRsCxO',
    'Sanni Tribeni':
        'BBV0y9R0o6xBzBhczKnJoGrFraxV1sBqgB3pB6C5LqGoFmM8KwF6KzC8IoM8ThKwHpKmV2UkDpLgFqFyG7EyQ8QyHFoHxK',
    'Tilagupha':
        'BBY6i7Rs6+xBrgB9mC3Q5CjR8P3OrPlIoKkG2UjDgXhJ+E7G0Z0G0V9IkBlB4NhJuJwCkO+hBDmJlQ0MrC8EnZ4JzFwJuIiLMwMhZsInF',
  },
  'Kanchanpur': {
    'Bedkot': 'BBN+w3RotgxBpH9SuE9K5EtQoHnEpK3I/RwFna/JrlBubgVqqBidqOooB0EgCtY',
    'Beldandi': 'BBIoxyRml/wB/LvM/PgErI4qB6PS7C2MsIRgP3uB',
    'Belouri':
        'BBV49xRkwgxBnBnIjP0BwE1S/N1GlMsNpG6Y9UsFnXscqFqiBkHgBkejT8LoHwF7G2N0BF1OmKvM/MoExF7K2HjT4P/E',
    'Bhimdatta':
        'BBcw84R2k+wBkGhC7WhZzYnJrBgFzctHlCqHtRvL2BjGtnB1CqB0c8XYlL6M8CgG7EwGzIVzC+KvOgGpC0G4O+I0f9ZkagK6RxFwK6IIvGqGHuM3P0YQ',
    'Krishnapur':
        'BBgBgg3R6wjxBuE3BjHtH1tCvfvH4BlCzF/PsHtC3GrQawK4YzEyXxIyGlXnWxYrE/X2kCiHgH+JpN2J2LvBtHmK3FsG+IgXrYuKyEM1GgO/GypB8I6Kxawc0N4I1Cb1IgNiE0H9I',
    'Laljhadi':
        'BBYorzRwgjxBlC3T7WjRuH3DlDpM/QjIpIiChKyH6FsCnKkMG2O1NzB1IyJ8BqGzLGpSqpBqLW0EsLkV8BoP/tByYsEmXoW0I1G8B/U',
    'Mahakali': 'BBK60zRmx8wB4LpE6gC8GkDjF3rBhatxB8DjIuGkCkUkE7EiP8C',
    'Punarbas':
        'BBWygxR+xkxBnU7DxEpLrLXqSppB2LNiB7IvLlHpemTjHd/JsV7X6EmBiI/U+W6MiI+C1Fm3BpL8P2WC+IyDlHyM5B4EjP',
    'Shuklaphanta':
        'BBamo3RmkixBBnIlFuEjehR7RmBlHvN3LyBrJ1N9RnCjWiK9E6K1FtDxOgHoE6KtH4D2K4DkEmIwS1CuC4GgQrHmC0FwH3BwuBoRqmB2V9GtYqKnS',
  },
  'Kapilvastu': {
    'Banganga':
        'BBZk0+Q492yB3Z3QldoKzN7DiF4YzTzMzG8M3FnCQwP9OlCrIqKuD2E9HoFiGyGzHsP2CyKuNyH0W9G8euFmoBzKpDxQqJ3kBtErD0EvNmI3D',
    'Bijayanagar':
        'BBags+Q+9vyB+C5ClKhGfhQ5T2H1NxBzJ4H9NhE3NqP9Ub1NkNxP9ExFwO8FwP/HkQwVBkN0H4GhF6M6CD1FoMjCmK7Q0drJmHzH2RN8FzQ',
    'Buddhabhumi':
        'BBpB+k/Qqt1yB+G+BrRvO7Ch2BtOrDxNcnI2HrJ9E3BkGlLyD/H1GrYxBtJmO3L1C/C5N/FehGgFgBiKkKgFrDgJkGsCxB4F/K+D9E9DpDkMjPetB0M4OyFmBqLoN+S6KqDsDrF6OXcsO4XwTlErZ0N8DmdnKqQqG1G3P+gB9V',
    'Kapilvastu':
        'BBai97Qqi3yB+D5C5FxU5OWtDsFrL3D7N5dzOnFqB9MzExD/O4E3DgO/K9DpGiJuDwHqPuC5GsKkK6N1JoN8T4R6P/I0WgR4UhBPvP4FoC2C/J',
    'Krishnanagar':
        'BBOmv6QyuyyByB7alOtCwI5N9FvPkFzQvJpE9OsHhD9HtJf9ByiDgZZ6C7T6PwD',
    'Maharajganj':
        'BBXqg7Q8t0yBmE4C6BjGjGrCsDhJjK/E6DnUzZva7FqB3B6SzYSc8W/V0T2MiBoHkH6GjLE2R6IwGuJzGkV2DsExM8E8DgG/F',
    'Mayadevi':
        'BBPgk7Qo83yBvTxRtNE7I+H5NrIzMzcjEmMtOhC9HxJkFolCyHkCqDzJgR1G6jBuD8ZrM',
    'Shivaraj':
        'BBfi7+QkzxyBavKhLF/E5MiFfzBzflJ4T1ROlH0HxdsJnK8QnMkCE2F5M5ChHgF7S5IpEmfqH0PgJ+JgGdA6K0O2FyJlOsYyBgI2GmLxD4BjGsJ+EkKjIka+CoDh3B',
    'Shuddhodhan':
        'BBSm96Q4n4yBiEpBtHhEnjBsH5MhFvUsHtD0JlJ/G3B+JrW6U4HiGmI/I0PwG6GnFwV6Iwc9RuR2J0CzkB',
    'Yasodhara':
        'BBTyv5Qwx2yB9JzL6GrKpPtCtDvHqGhJiL8DqBvhB5E5DrF0LnHjH1MhB1K6tB2BiW+HwJuOiCkElM4L6NgE1J',
  },
  'Kaski': {
    'Annapurna':
        'BBjBo7uRwlmzBlLviBzJ7Kvc2Q1hBhjBnF1MxIa5XxN/KuI6BwHtHmBiDzkBxOiOtQ+B9YkehK/H3EiIlHxFvLujBmHqUxFgR+TpBY7V8EoBqDxLsOOoG4I6eOylB4UkIvK6X6YmY8J4QyUoXlD+H5qB',
    'Machhapuchchhre':
        'BBgB81uR29nzBlClO7XoExQvUlY7J3YlZlH8KxlB3U5eNnG3IrONpDyL7FatC8IyHsO5D4OkGqJtFuFyL8Q6KmEF8NkI8ItIsK2dmdunB9K6nBwWyN9EmJsF0P7P6O9c1B9OqMxP',
    'Madi':
        'BBfsqtRgrrzBLhlBnU6C9nBvWpnB+K3dxd9QgI5M0S9mBvHcuRjD8CzB/IToGsI4M9TmeN4a0HqKwP0EoXjBoQjP+qBoT8TnCiUqTiLeiGsMiM6H+GzKwErtB0KrC4DpO+NtO',
    'Pokhara':
        'BBqBqppRu/ozB8HpKhIrIG7N5KlExL7QuF9EjGhK2D1OvJ1FpCoF5NjCwF9b/W1XxLuLsB6MrL4LK6VpQsUpPmELmfnH2NpG/BhKyIBiJ7FVtLsb4SmSmFmSoRjL+K+EuIsQyKoCgLxMoB1L2G/B1HpWsDuH4BtU+mBwH6MzS+Q/H',
    'Rupa': 'BBOyzmRipszBZ3bzJYzJtR3NjE5LyL/GnH5H2uByCoX0P9GgKgHsUxJqFuDwGhT',
  },
  'Kathmandu': {
    'Budhanilkantha': 'BBL2k/Qmtj0BFpP9LnE7K2BxJhG9F4CyB8EvRGoMqV2oByEwBhJ',
    'Chandragiri': 'BBIyw9Q4ug0B7FxOlXjFxPsUrFiSyTmDwJ8N8U3jB',
    'Dakshinkali': 'BBKil8Qmth0BzGvK0C/L7MhHvHoJxW8BzGsQ0V+RiSd6N5O',
    'Gokarneshwar': 'BBLun/Qw+k0BZxoBjsBxDvSjJ+FsU6HD2IkQ+M+EoFyYqM3BmK1K',
    'Kageshwari Manohara':
        'BBMgw+Qgil0BlFhQrMpE1IjQ5HE1G/SxN0BkOga0XyWiD+L4GyBuGzG',
    'Kathmandu':
        'BBO2+9Qg9i0BrIpQ+B5TlJ+DxDtGhV9B9C0L8IiF9P6b0NuL+S1DsH+EjGxQmQC',
    'Kirtipur': 'BBHs68Q8yh0BnIlOxTlDuHwK/H0MwVuH8GhN',
    'Nagarjun': 'BBM2i+Q8wh0BoChD/H/BxFvhBrLwH7RkkBkE3DoNmEyDuG+IhErB6I4LnQ',
    'Shankharapur': 'BBJ65+Q4xm0BrKxrB9MyCjD/LhPlM/FodoGsfkSmI2DmR',
    'Tarakeshwar': 'BBHoo/Qoyi0BnCzUhXxbjW8kBgeuLoBxE+PqE',
    'Tokha': 'BBGqo/Qu1i0B7xBtQuKuUoDlEqeuK0F3J',
  },
  'Kavrepalanchok': {
    'Banepa':
        'BBQ688Q8qm0BhB7J5YxHjR1UjJ+F4C6G5IiEuKybiN0L0KtDmG+L+F1NqI4NwD7HpGjHwFhL',
    'Bethanchowk':
        'BBQsl6Qynm0BgIzEzRhS5BvZ7iB2CtWxVoH2fmUgTtGoNOoWiXoSyI5BgBuIuItO1J/Q4PlM',
    'Bhumlu':
        'BBYm08Qigp0BzK5C9IsWjK9ByF+CvGkD5E1EvB0KnLuM3F7D5MkJiMkN+FyV4PTkF4QuMuEsI5FxC7MsHvjB3M1SlJOiMpFb3K+M7N',
    'Chauri Deurali':
        'BBQ+87Quls0B3J/T3PU9FxVhMjNtJqDjK8QwByH3buMgLmNokB6EgCuMmWyVgJ3I5BvPuK9M',
    'Dhulikhel':
        'BBSi18Qqhn0BlE3J9F4NlG/L5KsDjN/L9EcjCsO5EpKlN0KIqG5OjEqNwKqP8aqMuFf/TsT3CqUtV',
    'Khanikhola':
        'BBWy74Qi4l0BrP3M1O/kB9NvB9IsG0EmI/N8J0EqGjE+G1H4F3D/D+DqN3E+P6VqQN4F0ExE+IiKuX2HNvMuMpKnCvRsF5L',
    'Mahabharat':
        'BBe+h4Qi0n0B+JpHtX1H9IhK7EsEWxFpV3OIzLnDsEpF1DlE6JsEsI5KgQuD+nBuFkIvMqJ6G2NzEkK8EmJsRxE4VmMwL3M0H2CsHpG0B1YxJxFqHKmEzGvLvW4F3E',
    'Mandan Deupur':
        'BBRuj+Qw8m0BXjHrLlI3bzBjF4K6M2gB1YiefmI0K6C/MiO4CsI6W5IqMxPoHpY0KtHvC5W8GhL',
    'Namobuddha':
        'BBR+j7Q8jp0BlOzNmGvBsEnS5NxVrRzMpFwPxS6TkE2IhDkboNjIqEyH3OqZ0S4E2RzPiG6C8L/T',
    'Panauti':
        'BBc207Qujl0BuE3CxK/UtHyJnJtGkIlF3CjJ7RPvGnJhLqK6B4HzI+PoCyWkS0T9XmR2JgRgC5E8SoGHpGmNzK6EqKkCrOwH5E3MlX6IhEpD7EgF5HoHf',
    'Panchkhal':
        'BBY2i9Quzn0BlOrSKsFlOgGjGiKrT4CqB8T/IhFhK8CS6J/F2CqOkMlOiXqCqT8F1H4F8DoLtMwBzK6E2EwGnDxF5CkK+B+JxekYxhB',
    'Roshi':
        'BBe235Q4rp0BoEtEvE/HjKsJlDlEoDlYjE1IsN9NdxKxI6B9X/R3JqFK2MxP+L6L+PvBkLpKwByJ6FxB0YtHsGzH1CvL4M4CyHxIwcqc+KwKnU6VvRG1H8LtDmLvW',
    'Temal':
        'BBR+06Qwuq0BuDnRpGnItU8QzP3FhL2DvC4Jla2X9IiWyHiLyCzHoLiDkcxMgRxK9BjHuKpR+LhE',
  },
  'Khotang': {
    'Aiselukharka':
        'BBSo43Q8//0B2F7IrP1K9EvJwCpLzK3LrChsB1vBcoE4P6NiI2BgJ3XkG4Vka2C6WqfgGuLwK8K3CrB/E',
    'Baraha Pokhari':
        'BBT4svQ8ig1B2DpFnFzVpHvFwDnGtMtOvKgG7UnCrY4GhI+fqO2YmBiiBuMrEiOtTyS9CzGlH0F3PuD8GsShF',
    'Diktel Rupakot Majhuwagadhi':
        'BBSqz1Qq2+0BlE/KnS0W3NhCkB7S7Qpf9WlItQmLC4PzS8KgJwNS4UuV2d8H8b4a3B2KuL6VjYuLhiC',
    'Diprung': 'BBLyuyQ0/+0BlH1ShW7IxPxZje0RyGoe2lBqiCyTiFFniB8LlVVrK',
    'Halesi Tuwachung':
        'BBcsh0Qk/70B2DvE5GnBV/NzG5G6BvSpV7T3DnVjOvbjThNL4LhR+IlCmJ8Hga2M+K6K4erO+qBpZsekCyG2MoSgSqH+UjLHxPsI7J+ekH9HpWgIxJgC5O',
    'Jante Dhunga':
        'BBVqkwQu8h1B9BnHjJpCmF1JvQtnB1TsGxD7GzF4P0GmHxS+ChOuTtMsE2GkJ/ByM+gBuNwKNiHxJ6NqGiI/NiHuDuFlL',
    'Kepilasgadhi':
        'BBVm63Q+vg1BP9JhL+CtLvKpf/F1C5WvMzN3M0tBLiX5VkYN4VwS+KmIkMkR3W4JnBuDvJqI5E4IqEqO1MmQ3CL/a',
    'Khotehang':
        'BBOoyxQmmh1BhoB5rCxGnetJ6Mnf6EuQ2amD6a8P+lBlF2JiN4GxHmOwQgJ2I1EoazlB',
    'Rawabesi':
        'BBP8z1Q2k+0BqPpD1B/IhMxF9DnPxMzMlSO1N5c1Nid8Ys1BjB8S4NiCyStV9D/FqHnB',
    'Sakela':
        'BBOq5zQ21h1BiOzN/ab9H9b3WrgB1JkQR4mBzR3GsBqL4PgPgLiBgH9FgVyKsPhF',
  },
  'Lalitpur': {
    'Bagmati':
        'BBV+p6Qimh0BnPtQzFoMvO1KnFyIxXyGxVklClKiK8C+F4K4D0IhQ6R8ED3XoSzF/EpPuJtCwHsG6L7F5GpTyMmC+HzN',
    'Godawari':
        'BBVy27Qgmj0B9BpOpCyDtE/GoEtM5RxMlBrHlGkDvKzT1ExBhIuS/KvEqEifmLdbic0L8VqSWmD0G6J9SJ5LyGpC',
    'Konjyosom':
        'BBQqr6Q8zj0B/F9JHvdvJ+DM/K5L8FvHrGtJuCkEiSpO4Bka+IhC4JkJ4BWoPoNIgHxK',
    'Lalitpur':
        'BBSs48Qyti0BsD5KnMvHxHoDxKjJlG4GnRYsG8K6FCnEuMuEgHoCzDwB2JyHPqFzKoJJ0C6FuJ5N',
    'Mahalaxmi': 'BBM6u8Q27i0BtDhGvLwBnC2JpNkHpK2hBvI0C6EwHqJnC+K5U0WjWgB7J',
    'Mahankal':
        'BBU0/5Qwrk0BCpK/I7CP3O/IpB+BlKpY5IvFuCYqWhS5ErIgQnN5GvDoKoD+H2F3FgRuFkC/GqU6W2jB9CyEpL',
  },
  'Lamjung': {
    'Bensi Shahar':
        'BBfsooRqlxzB+F/OpGrS/K7KiIpDZ9KrEqGzFzDhCtQrMgIpD9RvO7Q1GgF0FiUtNyD8CoI5JqXuG8F9FsI4C8F7M2DwMqO1EuF0NyI4Y/EqBxMnM+DP/RqMzJqEkMuZ+P',
    'Dordi':
        'BBjB2zrRw50zBAvGhHqCzN5U7fvJzGpM7P5KxBtRpQrdhLlM5HqBxV3Q9DhM1MyJQgSoM9DpByM3YgFverLuF8jB+IjG6GgEkCvLuPyBrCyU7I2M8D8QqcxBsvB6jByK0NrCyR4M4DM8GqLgJ81BtsB',
    'Dudhapokhari':
        'BBX0npR+i1zB1KxPhmBhY1H9KvVpDtIiE7D7Q8I1MsCxUrPvBlCuLnNrB1C0DyJmOnC0MhXsHqYujBqbkT2QtEyV0L8RlDsTiIiBrM',
    'Kwhola Sothar':
        'BBUihrRyntzBhQ7N7ToC9qBnTnQkP/jB9BvB0e2GyFzHwIgNyQqD+RqS5LsQ2IlFphBwIhF4LwSiDtHiYhDuDnH0kBvU',
    'Madhya Nepal':
        'BBUk9mRo/tzBgGlFzGtF9BrOsF5LnJpP1JyRpFtDrUyJ/J/GhcgJuZk5BgOwBuFnEnDtGgNqH4HjCsB3WmGiE6JxH',
    'Marshyangdi':
        'BBoB86sRioxzBrE5L7TtEpJhL6CxPtEWzF51BoH/LlJjO1OxGplB+UtDoHhYiDhDuH1LtSxIgFmFqhBnSjIrD4IwEwGrE6B8GoGsEpGa+KhIqDsL2LuGmU9ByOma+mByBuR8P6K0GqM6fwJ2N6UwZ/U0DpJjH7KlGtlBkYrSoGhM',
    'Rainas': 'BBMq+lR47yzBzKjZzDrd1O3D1iBwfoN6D8H7FbgW+H8R4JsH8WvF6CxM',
    'Sundarbazar':
        'BBUs4mRg8uzBnC5QjJ/HrB4W3HkC/MrHoDwGtFoE/NvBsG+sBnK4XyjBqFtL1R8M1D3C7F+FrItG7F6JpX7CpI4M7C',
  },
  'Mahottari': {
    'Aurahi': 'BBJyxtQ0zs0B5HxapJlCLnOnOxM3JiV7N3D2JyV+sBuQ',
    'Balawa':
        'BBRghsQm0s0B7DzLnV9J9JzNhH8C1KpGtI2EoHoJjB8InPzFtC2DJ0J0JmIyN7HsSgJqCnF6cwE',
    'Bardibas':
        'BBgB2zyQ+ps0B3SlVxa4CzBhH5xBzc3HypC/UtL1nBvI8DiKvSvG1CsK4P+IF2I1JtEgOoNtD+GqjBgK0BtHudqDiN2JuG7HqCgL2LqIwJvGmMuBwOzT+ID6HlO/L3MqM1QmI6E4E/J',
    'Bhangaha':
        'BBU6xtQo1t0BzOnQyJgEG1IzPzIqEpLlM3GvUnBSkP3JQ6B+N9O7C+FgMiHnBxKgP+EqG4d0E6K7BiClN2UY',
    'Ekadara': 'BBJq0pQkvr0BoBtbhduC1E+RgN3CxC2H2LoKuHT8CrH',
    'Gaushala':
        'BBP6yvQu8q0BEzI7kC/VxBuN6HmH7FsRxS9HzD+H6H6EIiO4IsBuI6U2kBiFgVwLwHngC',
    'Jaleshwor':
        'BBU+jpQ8/r0BjIjM0HlDpF9DoD7GvLkE4B7PzHdrHyCtImevNiKVmIqM6BuJ5H2KgHwDzD3C+IyGcyKzKNpI',
    'Loharpatti':
        'BBR64rQiit0BhB5N/TjEtE8EnQzIjN+H9GpJrGsPofsO2E+L8QiJyHL/DvE2K9OjHkB9F/L0NiD',
    'Mahottari':
        'BBQkrqQ48r0BpDzH9Q3GxFqInQtFnFwCiJ0KRoKrG8FgF6ImEnJ4N2E4ElCWzRyPuFoBhH',
    'Manara Shisawa': 'BBK68qQ+wr0BzBxhB57BnGnWgQiGmDmP/IyRgEyDzEgEudskByB',
    'Matihani':
        'BBQshpQowt0B9IvBtC9JtH7DgK/JtF1EiDxI3DsD/K/GxPsHnEsM0OyGqQuaqJnFqEuFkB1K',
    'Pipara':
        'BBRwqqQost0BsJvDze9LuFhKxD9C3K2DnFtFlEoJzH1J3MoTuH+DuC+JgJiBiB2L0LnMwOmE6N9G',
    'Ram Gopalpur':
        'BBNsvsQgir0B9TzClBzHxI5DS+W9WvNXmOqNiTwVqKkHzKpK9Q8N4DoH/O',
    'Samsi': 'BBMujsQ8gr0B6NtE9VzMTnInPsInQREgOgK2BuG4L4GX/D/U6UsL',
    'Sonama': 'BBM+utQg3q0BsFxE5HjHjCpS/OrFjFhInNyC1N2hB+cgU0D9HiSqIclN',
  },
  'Makwanpur': {
    'Bagmati':
        'BBjBu23Qqlj0BVtFniB3NvJ3d/gB+F5OuVpKwmB5NRxCuJvE1EvU6C5G4f7M2FjBkS6F0FqElJkEuH8GvCB4NqGzFuI2BZ/J8d1EgKjbkX9LmHuEwCmN0IgB6EgMyLqHuLrMtE5GgO5J3DlVyOlY',
    'Bakaiya':
        'BBjB0z4Q+lg0BxEvHzMQ7EtK3I2BXqMtSwJlT5ChGtY0CzT5RVenKrJzD3OsFtc6iBc2lB1N4LkD8chG6ZjH6GhBmU8RoFyCtJ6NS8R92BucrM6MkC+BqTkImLgiB6PuEhZkKhN+B/jBuFdoG9R',
    'Bhimphedi':
        'BBjByp7Qq38zBrOjLzJ2D1F+K5EtOlGhB0B7K3H5D7kBoFV0R1G0KrF/B5CuMsV6JrH4YuN9I+IyOGuUlI6T7NJhE0XlJ+IekPyM9IoMKoFxIwO2K6FpO4E2BgDlfwMne2FW8C1bqJvHsI9d',
    'Hetauda':
        'BBhB6x5Q0y7zB/MnTkDlLlLvDwE/LxSrFjJie5P0M7oB9FoD8DlHuLwG8Q9HmDP+KwI2VnCqRjawMrC2IsJ0DdoK8RYK6cmchIzB7NoF7E7F9IsM/hBhD7G0apRuF8BmHhcuWZsFhO',
    'Indrasarowar':
        'BBT6j8Q4vg0B0HxK5WlKpJnL0NnVlSyF9C/GzUrB1M6e7C4e5EvBkH0KwMgFqB+FsGxOyW7BqHnJiNiH4C1G',
    'Kailash':
        'BBWm98Qsw6zBEnJvP5LtIgIhLtL9PA7HmKtQvI5S+RJgSrPse+SyEzB8KmGiB6EuO2F9KyJ1DibiNyOvaoWhO7EtK+GnV',
    'Makawanpurgadhi':
        'BBYmq5Qqn/zBR7YjIrMlNiJsH3YrV5JK1JpYgPsDsGrMgiB8F+InF8E2B6NtaoIasO0TwDuSvJYpM4I1B8EuKgRyCkD7KoNoBoGtP',
    'Manahari':
        'BBb+n7Qij3zBlc7QK8KzOsV3Cma1IOxKiL9bpH/OrOxN6LkB4O/LsLRwPrOsPtIwcioByGsMrIiNxiBiTqF4GnWqR/UsHzBXpGyG/GqLiD8GvImP7hB',
    'Raksirang':
        'BBbk48Qsm5zB0DtMjN9R2J9E5SrP/F3OoFkBG7IxL9I7RqL1VguBvL9CzFmNrH0BpRgVnLoiBmLwD/C0L8OmPiThvB8OjHgNmJ0HjKqHR4JiB+J+K2Svc',
    'Thaha':
        'BBW+n9Qu99zBzN5d4JxC/E7EoGlMCnNrKhOnWiO7NganN3CzIqfpJwH3C8Z8OsC+CgHmSxFlIyHnDgTmekQmJtKtGhduZxf',
  },
  'Manang': {
    'Chame': 'BBK62tRk2tzB+MpIzkBxY7I1MxIyBvEstBvGiMwkB8UuM9M4CpV',
    'Naraphu':
        'BBqBou0R8oszBjRrSoK9Q3EvJ+DnMzX5GpE1UxM3CtIxOhRmGlGxH1RW5N2VyFmRrDmRlNhBzJqHjWsnBxWqEjfsd8kB6H8PkVgHkXwR8EuMonBmK5BwGoR4SnBoB4M8OuFmFpImMgC0GlKbrLmOuFgExIClYyI/ItG7L8IrWgN9N1E9H',
    'Nashong':
        'BBmBw8xRiixzBd/JrSuBzE3PtMEtMnnBvR7E/GjX7PjVhVhH7X4L3CqVtM+MvrBhctIgGuEw7BuEV5CyPqJiLkMaiM0JnGiSjYsSmGulBkH8KkZR+Q7E6CtHstB/CsP9OkHkCwG/FgN0E4C7LoM/LmKqG4HnHsN3d',
    'Neshang':
        'BBjBo6yR4hozBmLpHrChKpazClL/Z3Q5DjN9Q2C7L7H/TnN9O1Y8lBpZ0NxHkqByC0P/MgQ2B+O5O+czP8PUwgBpRoQxF0OsEoI6jB8Ykfrd8V3D6W9nB8JrH+MkBsDlR1FnQwE3MsJ5J4RXmGyHsK3D',
  },
  'Morang': {
    'Belbari':
        'BBR05pQmis1B7DpM9Q5L/CvIvMhClRyGvRhP/lBsMsJyPxBoQ4K2InEoIwZ5FyqBiN0DjOqOwEyI/O',
    'Biratnagar':
        'BBSi6lQyjp1B3H/GkGzC7CtV/UnI/KiFlW5C5H2O7TB0F8YkCpF+OhB4IkG8PnBsShJsDwSgQ4DmBxN',
    'Budhiganga':
        'BBQ25nQuyp1B8GlB3GlEkCrKpFlElfhGvX1XhBgFpJnB8CuV3FmE8jBkNsLwPsO8BgFqHkExR',
    'Dhanapalthan': 'BBMw9lQihr1B7fxbpRLfgFnSqD8GqMiCwY2NkYuN/G+H/W8OMsJtL',
    'Gramthan':
        'BBSs2nQq1q1BpEvXhPnCtMpQxc/J/F+c6MKekP4GtB8BoFxImCD4NmR2CwM1I0C4D0QjIiCuEwB3F',
    'Jahada':
        'BBRsglQykq1BjUvSgC3OjLuC3IjG9OiBjCqFpFhKhFqHoD8G5O+RqI6K+QlBuM4HoSpDgB/EiUN',
    'Kanepokhari':
        'BBOk7oQu9s1BgF/C1rBjMvZ6F+BvMxZzF0BqUgLoJxJwIUkJopBrE6TwLoUtB4C/Y',
    'Katahari':
        'BBS+pmQuyq1BvBnG1GuBdjP5MJmC1M1N9DT3Q/Y0HzC0N2RqN2GgRgXqLoDgLmFpDnFnFgDvKiIV',
    'Kerabari':
        'BBXg6sQ8jt1BqB1L/InW4HzT9CtSxMpOuCtNnSgBvU9Ptf8J7N9I9H4duE0D3B8N7RG+CuI8c+agNtGigBiC8NjGhC+d2P+NqPlC',
    'Letang':
        'BBWw1sQw4t1B9DpUpI4BrP1O2C5c7NkGhgBhCrGiHjN5HjKgUrOvE3C+NxEQG2xBwNjBlEwa0axSqOvU8uByIsFzGuJgE+J9M',
    'Miklajung':
        'BBR60sQ4lu1BzB5J3H2JtJ/DrF0GnvBrIle0iB2CuHsLiE7G2RmaiX8ErRgNiKuKvOsKuDyd1mBF3X',
    'Pathari Shanishchare':
        'BBLo8oQ2vu1BlBtb9VoE7U1LrN+BrQia2DuN2JgIkQ9D8csHqP5R',
    'Rangeli':
        'BBWu2mQu3r1BvKnUlJ4EvG/EpI6J7OL9HgXxQwErLyuB8GsDkSjJ9DtEyQlO8J2GgCwJ8FtEgLkGuM7OhL3KzBpUgPkDgExN',
    'Ratuwamai':
        'BBXyqnQgrv1BrB9QxJkE5SpN9IuGlK/HnG8DFjF3ciBjF0J9E5CjBiIlRuD7IvNrI+BiHuoB4HfmGyR8MQ8OrNydtJsb4BgYjP',
    'Sundarharaicha':
        'BBN24pQsxp1B5jBpY9Y0JjCqK2GyE3KgCDomBwOoMmRxGse8B4B7NrExDyHne',
    'Sunwarshi':
        'BBb0hnQmzt1BvBvFxM4F/P9HlBmF5J7G7FuE/BvJ7J1GxQmO+DuEjSkJ7GrDjRmd2J8NyRvDkBhI+E6CqF1JycfGkFoG7DmKgI+ItGsJsFxD5N6OpV',
    'Urlabari':
        'BBO28pQywv1BvNhO9M8CyHxMhE/O7Y8XxjB3Hc6SpTiLoY/B6L4K2X1I4jB6HmG/O',
  },
  'Mugu': {
    'Chhayanath Rara':
        'BBlBksjSsimyB9GhYmD3WzOrhB6KvMvDpL3gBzHYmgBjMlCpK2H7HrBsDjT5HjUmOnOpXhGpFtL7IkEvOshB+BwQ5O0LqHyRpI6HtRUrOqZOwSwNoFwGgLmC4hB4W6HwJxDqNqKkPpe+LnDyOyEzH1P8QlPiqB0G',
    'Khatyad':
        'BBdwiiS2+9xB8OrPvC3InH/BpGsK5WsFpfvLrCpLpD+P5cqMmE+kB3KoL5D6cqF8U+QoJA8QjHkF2N8S8LxZ8IjEuOoIyL9K2GvQ1GjSiE9MhEpKgHpNpD3P0U5W',
    'Mugu Karmarong':
        'BBmCq8oS6ysyB2Fd6JjVzfnkBtNlCrGzMxOsJ7CnR/PlDhMuFxGxXnRuHpKxJnSwKlL/B9KvLgMlhBnCxQtMtTyG5MtBzSlUsDjsBhKvRqP0H2PxOxE9LoDhJ4WtLwHjKmd2GyOnhB+ShB4PsLwGmS+aztB4K1F0coIkoBvQQhIsLgRmc+H8BgEsP0W6MmHrH6RoFiEifmXwN+E+JktBvP+KuUwZC6HjH4LsBoGriBiHsCuOhJkD3RzEhVwRwCgBkKgN4Q0NxGmC/JqKrItN9jBkC1LyUuN6LhZwjB3X',
    'Soru':
        'BBlB4hlSmwiyB9IzU1TjOlS3cyBjK1IhIqCtR/d/W+BvrB7U8fzPgMqD4P/GqNiEoKhEgNqE2ZxP6T3KpCqByFkU6B8DiG7OuM6HkUrDkT8HsBqK1HkMmCXlgB4gB0HwDqL5KwMqL6G+HhI0U1E4SjU+KP+B9G',
  },
  'Mustang': {
    'Barhagaun Muktichhetra':
        'BB1Bqo3RimhzBlFpEremB5D7PrPxFhHrNnqB/kBxTsBXxM7hBqDwD+SpE8MoQkcIqXuJoH0NxBgKie9DsRpN1BzT8J1D2sB9EoChKykBzJqEjIgU6QiKuGiU2WLoGwHR+FtK8ErCkR7JkM0P0UyM4CzB9I8MrK5BpH4J5O+WrI2HxOoKnF2DtQ1LhzBkfvDH3GuK3D+Q1XyB3N3HlK2InT9CrT6P3gB',
    'Dalome':
        'BB6B4l7R2zjzBElU1T9Q3F1RvdsE7EiI9P8CUzMxMxGyB/MnFnItL0J1KI9EpIxMwGlDqTlH6H8C0TzIkS4HiLxB4NphBimB7X9C0K21B1DsQnKoF1HyO9WsI3J6O6BqHlNwLoGwc0X6G9DoM4EwJnK8QyR4Q9D+ZwNrD08BiR4TtD6FtNjEtTkVnC0JpZ1MtOwC5E2hBngBqL7DiJ/NjGlW9gB7N1ThW+TrIqpBznCuMvM8MnD4Upb',
    'Gharapjhong':
        'BBew6zR6sizB1JzgBzNyBtJnHHpX3EvC3GwVlkB6X1EwQ9Wve3DkP1LkHgBoV+HuM5DkLuHmFboUiQ0W8HgU1C8LkN+Q2EJkI/T+IjD4K3lB+EnC2D1sB0T7JqN2ByDzO',
    'Lomanthang':
        'BBoB878Rs9nzBhJ3K4Fla9JhezHrF4CjWrPrLjR4B7D7ejGA5M0XxO+EtMwMppB0nC9TsIsT6VknB0VK0OjJiOlfgUpQ2U2M2OpI+akNkI0MPoEpQgiB5HwNwJuE8NqQarCrlB+ExPoWsCqJlU5F7L2JxPvJ7K2G7WwL6FmK1V',
    'Thasang':
        'BBd0xyR4ugzBiHHrPjbsC9U7RigBtL0B9VtN1IyBvFzH/UkKzGkLlXyB5O6J2DyKlK4chE/CVqNuuByduJ4O0O8D6DjLrGnHrD7XwM1J+CvO4X8d2EvQmkB5X0DpT',
  },
  'Myagdi': {
    'Annapurna':
        'BBhBqrwR8ykzBAzevOrKxHqB1ZxbndhOH/PiEgDuKjevI7MvP6J7dtKhfuOxDuNlKjLlZrE1GqV/TmSuImL6W+InDwsBuHlB5BvHgLtI6XyNyIZoF2M2hBijBwc1Q0J8KmL0gBqZxNuW3iB',
    'Beni':
        'BBRm8qRsy/yBpDzRzIiB3DvPFuIlH9BlFsFvHxPxTuF/DoYpHkFyImR3LiY2KxCiQ/RyVasVlU',
    'Dhawalagiri':
        'BBuB6pyRo/+yBK/L7ElC7NztBwB1NhSzQsC1W/Jte6LrhBxFvIpSlBjTnJfuR7D5B9UtlB3alI5SuYvCkP3L3GrQuJuBmL9K+a1OmOmK6PhhBgnB6XxFnB0QnGuGmD6PgJgGpHkbmRsKvD3JwHnT+NtE0S1U6M8Nqa2BivBsY6DwIzFuSgFqHmJnB+VuNqR7EiK9b',
    'Malika':
        'BBYossRqr7yBtKhPhHuCxHnG9CjLxHoB7I8NlenLhI2UmK6OBmRjJ8K0ZkIyE0H5EgNwRgC4DsKgUjE+CxK7EzGoGtGoBzQ5XyFihBjnB',
    'Mangala':
        'BBUirrRi89yBgEjElG4BtDlKvR/B6E9MxE1HpYxFN0Q9RkUrF2aqUjEuHyPoFrFmH+BGtIqG6R2PjRmBjPoHnH',
    'Raghuganga':
        'BBgBkqwR6p/yB4FzPvDnIrvBzYpa1B5M5NzS0U9NuEvHoTwD4JtTrPqJxW3IxF7NqB7MmOlBkPzJ4NgFwP7X2WqPoSyUQmKkLyDtNiftO8duKqJ/I4K8C6O5JmXxB0GjLsR1FwDhH',
  },
  'Nawalpur': {
    'Binayi Tribeni':
        'CBdy29QwnmzBPjVzPwB2J/nB9JxhB+FlgBrWmRpN3FvB+HqI2K/GuXW2e9ZjE7JlJlKgL7ByRtZByJ+GnUgW2HqI0BuOuJyE+H/GiI0E4nBvG+EqF8QtP4cmNwEpYBK11EoM5DnOnG6GxWmC1CiK6HwT6IkFtEtRiUnFyCvG',
    'Bulingtar':
        'BBa6+/QwirzB4F9C3IpI3MwC5I3F5J2IxNmBnNyY0JqOuF0YvG8TsQiNgC+QgO4DkM/ItD5O8IjRT5HzFtBmGtH7EvCyIxEAhS/H1KuFHwBpT',
    'Bungdikali':
        'BBU0ogRivqzB6BrK9M7P4EhP3JjFzMgE/TvQ5JrBlEgM4IgSlKuW4G8LrByMyZ/L2HkGkGlEwLmF+ExCjCtIgFU',
    'Devchuli': 'BBNmw+Q4+szBhFnahP5QtOrD5MwH5JzB/KoFlKwPmKkrBqZlI6ayJoLzHwE1Q',
    'Gaidakot':
        'BBRq9+QwouzB7CrK9O5MzLmG/azJ7YmIqWi2BvN0UoPqgBwgBtH+KpQ0B5MhP/GjGpN8L7OiOnBuHrP',
    'Hupsekot':
        'BBX6y+QirpzB9IpMkE/L1N3CjC/a9MtQjHmNjBsY/GYjD8QlSFtM2VpOmCnC8SkNuBqDwJqa9BtFgSod1B2OqXmNrYxF3ZmKvZ',
    'Kawasoti':
        'BBZ639Q41rzB8GEtMnW5Z4DhD5M6FzG/aqBrDvJjNtBqCtIhFlC3PMvIqJzJ7BtEwJX+GiIoHmagH4I8a6J2DsFkK+W1U6J0B6MvHkKsF',
    'Madhya Bindu':
        'BBbmx9QijnzBzK3L3C6DxOrI7QuP9EpF1NqFhamBhIzEhH6G5InC6KurBzNwSwPmYrBiK0J8B2R9K0LsDBrKqOlCsM1VgSQsDlRkGMyEtMxChNgHxO',
  },
  'Nuwakot': {
    'Belkotgadhi':
        'BBQo3gR2u/zBpTnWhDz/B3G1HhVxE2EqSvM+GnOgnBzIkGwDuYuGsJwT2B6GyL2fgD0I7C2D5S',
    'Bidur':
        'BBVsyiRsw+zBvCnEnMkH+B5G3F5D0GjbrO8FhI3H3LgW/KnBlPhRnGzCxD+E+H8tBmFXiQqWoMvDmUoe4FhEsImIgGjjC',
    'Dupcheshwor':
        'BBQ0mjR+hl0BMxJjLkCzKzJ4FjjBhmBoBvHhH/TsHvGogB+D6dmamIka3D+QpRgHuBQwH8GjH',
    'Kakani':
        'BBQuugR+lg0BnOvFxVyB5GxLvT1BtGrJmJogC4HyH8EpD2G6EsC1E2CkKiR5GhEzHwOpFuHlgB',
    'Kispang': 'BBNywkRu5+zBuE9H/I3ElGtV9kB3NuBwc9ToOoCqhBoXqEqFlb0G1G6buXc1V',
    'Likhu':
        'BBP4yhRqhg0BhJ3PnMwD/FxGhPu1B9P4HwB2FwPiGwJvO0MgEwB7XyFvBtDzK6HuC0H9J',
    'Meghang':
        'BBTimkRy19zBH3J7VtShCjb3R0I1F4RlM5BhN9MtBqF7OpEgG8kBoVKpJ8P6EqToMjHiHqG6J3JEjfilBuM',
    'Panchakanya': 'BBL0rhR6hj0BpE9yBjExFzD0D1K9EvOkVvB2buTc7C0VuVlHYhG',
    'Shivapuri':
        'BBSq4gRi6i0BtTnByErhB5MpElRiH/Bic+MyQzHiJ2HuMpNuOwHoKjDkHgR6C8L8L2HjBjDja6I7aSpa',
    'Suryagadhi':
        'BBPqxiRuni0BEpNnLvIuFne9HzH5FiElG9MzMwI3HzCgB0iBqQsETnGiKiBtByZmUwD',
    'Tadi': 'BBK+jjRwsj0B4DZzErPhO9IXjNzXjCyBvZ9WkE0Di9Bs3BO',
    'Tarakeshwar':
        'BBN6xhRun9zB9Exc7R1KvXjC/E+KnL2EO0FuGlC4G2H4DqWgVwRyP1CwItW',
  },
  'Okhaldhunga': {
    'Champadevi':
        'BBX232Qy610BzBhIpJ7CAhY3HlExS0HhKpQ/IyB/XhX/HyQ6OsWxJqKsbyI1G8MwBsR8I6IyJ6G0KvNoHD0JmKclKiNpGa3N',
    'Chishankhu Gadhi':
        'BBOwg2Qo660B+OxDuNtQvamJ/jB6B/CuQhRkB9CoegM+WyRhB8H6Lib1ExIrNU/1B',
    'Khiji Demba':
        'BBR6y5Qm120B5C5LjwBjzBzCmU/MsGrPoa/OrBmC6M+N6LoDkO8F3E6NqeiOgIqT9IqB1KiS9MgF9b',
    'Likhu':
        'BBP2/3Qy200BhcpS/bzG3SmBvM8LiKqQySzH+I0FlB0W4KsEZ+UmG2DsT5b4M/F0C1T',
    'Manebhanjyang':
        'BBPu40Qow50B9K9sBvJ7B5PvYnLWtEnIvH2EpKsU/LgH8YmnBuEuWkUqW2IzEqGoDmR/iB',
    'Molung':
        'BBUk33Q8s40BsEPnEnMjMtU7F4ErU9mBvHmGKiL3TuS+CoOlG8J7OuG2K8BsC+UgQkRM7S2H/DoV0L8Hlc8PE',
    'Siddhicharan':
        'BBcuy3Qm940B0HvHsHsEyFhInY9I1ImD7HmctWxLdgFxFhBd4StP/QvChVlNoCtTpL0KotB5K0P1BsRjV6BwH8kBkJ2H+CneiRjBgDtQgkB5BygB/M0SrTnDnR',
    'Sunkoshi':
        'BBX4i2Qmg30B+GtFvJ/KpILzKwNlSnP3B3R2G7MnHsBpP5KtJ2I9F6cpQ0BtG2P0FoN8KdqIoI8HwQmdqOwRtKmG7J9CnO6M9M',
  },
  'Palpa': {
    'Baganaskali':
        'BBVizhR+qgzBmF7DtJtTkH5E5GhC3JyIhPcvH6S/K9F9I2H1F1F7IgGM2O+MgHwMwTwNiB2StGmC5HoFmD1B7PuG7P',
    'Mathagadhi':
        'BBgB2rgR42hzBhS/V9M9GWrN7Y+BzFgKtQKP3KjMjK/KyHiD+GzFfvCkOxIgI2B4ThSqa+M6FiXvQzGwfqJ0d0KBqJlEwChhB6KnB0GnNkOjHmD3emE+NwD0D6G/DsB6GgTzL',
    'Nisdi':
        'BBeoigR4lpzBqDrGxG8Bb7P5NhI3LoDkHhLJ9MxKtU4MpLoCrM9RtF0E9TjN1OPpM1NZ0DlH3FnNxC0F9SyDjJ8rB+PZMmlBvFqM+MuQkCgbyXkE+TwQ2M/D+IyE',
    'Purbakhola':
        'BBfi3gRqvjzBuBrF3X5FxGwUjL9CLthB7I7I3OiJpG+MlL8BlC0duHmL5D6G8NmBQqMkN2OzE+T+RuF4C2IqJhPtD/KkF9FrQ5MgLvUsQoBwBnMrG7I+K5B6ChGoGqCX5G',
    'Rainadevi Chhahara':
        'BBiB2hiRsv8yBhFxU5QvEgCnSxJlH1FwIhInBxIqNpJhIHxKlF+FxOrMoCparF3KnJwKtLvB/CiI3RiBAoQgH2KNoQ7F+GoPoCqCoG2nBhETiNlHgFiKiHkNBvGoQqRkEiVvQmOPiGlJ',
    'Rambha':
        'BBZ4nhR6tizB4GlFvPpM/B5N7duNvDiHtElH5GgEvDzDrEzN7DsZiKqMMuhBkL+CoItUiW4FRoMxGjC1CiG4QgCgD3H7EnByM7OqCtS3E1D',
    'Rampur':
        'BBbyjhRy/jzBNhErdxB6CkXpP3BvHwKzEmLkQmL5E8G0DmKnb8eyKuUK+MjHmL4LrD+P4KkI1DgC1csF3FjG/IyMxdnJ9LiFnInIG6FrP5CxIsWhb',
    'Ribdikot':
        'BBay0hRk88yBuDrD3KGhVwQnRhEuGpQjNChKhHmH/Ec1MjVA9DoP2GoH9SuXwNuGnIoPyDkC8DjImC4S4JmGwoB+BmLtNyB9P6F2GExSoHvP',
    'Tansen':
        'BBZ4yhRon/yB+D/HnHC3D9N0KngBxFjIjEmV3F1GzB+P9KoN9cqCrMxECgJtFpElFmNvIWzCgV0M2VoNzKyF2FiJ1HgL+FuH3SqPhB8M1N',
    'Tinau':
        'BBiBmx/Qq7+yBF7InJ7FtBzRjIiFoInPvNtG8StXvG3FuDlQzSmDjCpGnPnCrOoTyI4L3IgK8CuQxJ8GoDgsBxOstB2FiBhD9GiLzHiMmKG2K4QHyF/J0JQmFrE9HvQ0C/UwIVkFlNuFqE',
  },
  'Panchthar': {
    'Falelung':
        'BBWmh0Q0i11BwC3H/IhI+CvN5G9FsDhOzLzC/HwG1GvHnTiD9CoStTmQ3D4QjNtI+HqeN8Y8PH6HkKqRuH0cnE2D9tB0K1O',
    'Falgunanda':
        'BBPgkxQkzx1BuITvI/HmGnZ1EuCrI/KzZ6LgBzIpFtC/YsakRoRnEkY0Z0pBiOl+BgJnF',
    'Hilihan':
        'BBQ4/0Qq+w1BN7IlN7EvfgsBnLnEjHzQ/T9EnDmHmJqTZ6RkLiNoEyW8hB1F8DzkBoP2E0JnuB',
    'Kummayak':
        'BBP4jyQ22w1B5Fzc3I3G7Lhc9mBhhB7CurBpNqC9DuGoHutB0JrOqFuCf0I0Z5L6RsOyUd',
    'Miklajung':
        'BBV8yvQg6w1BnE9pBnM0DhEyMhND9T9oBqBvPyKjHiJ3RlQpCrU6G1K/FAuXzP+OQkhB4MogB+Z0DoE2HoOjS4a4VgL7J',
    'Phidim':
        'BBT89yQutz1BrBpRjLhNa5R9GrHctTjJjNzI2DhQjGrG0XwIgI3RkGxNo+B2E4JqgB0jBkEhRuSnO+DlUiR/C',
    'Tumbewa': 'BBNmiwQw2t1B3OR/RhbnY2lBlKyG1BiQ+T+oBsNB4DrMmLPwDrOgOlCiD9rB',
    'Yangbarak':
        'BBc253Qwm41BkDpErP7S30B/U7c/gBmCrjBzEvPuE1ShI1mBxOpGtDskB/J6G9CuN6G+F7CyNiJgJzN+V1D+tB4UuL0WS2EmI0GhC2T0PwVtPgWmD+HqFsFuPgErD',
  },
  'Parasi (Nawalparasi West)': {
    'Bardaghat':
        'BBZgs8Q88jzBJjHzfGzQiJngB5Q9D4MzShM7EkElI1EpFuHkNqOnJmEqCgRpFkJyKyIzE6L+b0TmU9VxJ9GuZC8BvRmKhLgKoJ6ZiE6CthB',
    'Palhinandan': 'BBL2i5Q6jizBkBtF5K9CoEza/IG7eg9B4BqK0XzKsFxJgI4BwG9R',
    'Pratapapur':
        'BBRs/4QikkzB5SvO5I2H/HvDlGsK5FlIiDjF/HhCnT2pBkN6I0R5EmDyKsE1E+QiH0JhWpCpRmJzD',
    'Ramgram':
        'BBX236QushzBhHrMwB1JtRoBjJ/F/HoHtMxCjKklB8L8F3IyU/H3BrD2FqV2JgE/JwVK0CzE6OsELvHnM7G2G9HnOlCsQxVoKc',
    'Sarawal':
        'BBXgj7Qi5jzByE5CzI5L9kBpS/PuB9D+JzUhKtZoPzC1KxK4WgIiChDkF6FmImGrKgIwDqSlIwB3GmI2E8EjE0SiM+D3MogB6QmH5F',
    'Sunawal':
        'BBWw78Q+vhzBhRpDzetjBvZ0E1BoSwHoM9KZvQyWsOmB1GiIoM4GW6GhP3DrBiEieoRwJmMojBbyDxNrI7KiDhP+QhTUhL',
    'Susta':
        'BBVqo5QupmzB/P1UuEnOpJ3C3E2L5QjHrE2EjDvK1R4EjN5I7T0fqH4PqP0LoEV8BrU4VnDsGwRkbvGkFvG+FsOwFpK',
  },
  'Parbat': {
    'Bihadi': 'BBNg9kR6nhzBmE1K1S5JrK5RhSUbqK7O4R8FoIkIvCoBwKwRJqDhKyW8D',
    'Jaljala': 'BBL4wqRm4gzBlLvRrTbhUiUja6DJ2OqJqH8B2N2gBdua5V0GpS',
    'Kushma':
        'BBT8uoRshizB7B1N/FxBhC7O1FzDlT4kBtTqF/KsuB6X2kBgGxI3EpiBkGjEmH6E8DtJvLlI8TqFqGlR/HzGqQ1M',
    'Mahashila': 'BBLsslRi6izBwBlZpT5EchU/X5CjGwY8DoKqJlH2K4jB0GyGwQ3Q',
    'Modi':
        'BBX41qRk4izBPlHjRpFpPzN5lBoDtQmNgI0GpGmR7TpFwLmI7DuJlH5EhGkE2BkhBmQgS+FlByIriB8G0FmFjI+JiI+YlesQ/BkPrO',
    'Paiyu':
        'BBSwtkRi+izB8GrDrIrIvBxRpJmH7DnKmFvP9QInBvK9MV/D0H0HgF1DgNwJyX4D2CuD7FyPiP4JnC',
    'Phalebas':
        'BBPk6mR8mizBzQjUrYL/O3ShH2JP4SqT6ExByciMgOpBsR+E4D8W/EnFvDWhK4L/mB',
  },
  'Parsa': {
    'Bahudarmai':
        'BBOy3xQi84zBrEpLvNewEnMlK9EtH2F6CqJvFsExI/C1LgP6dqL+TtC1EvN2IY',
    'Bindabasini':
        'BBO46wQkv4zBnBnL/V3D6E7R1J0EhOvCsDuMxLkHwHmJsI+FyI/E8D+EmRc2E9E',
    'Birgunj':
        'BBgB8/yQqn7zBgc6GIpI9nB7LpEtHtHrBYyIvIhExD9WlOrBjH9H6IvMjRqC1X7MhG6ByJ7N3NhEtN+bxNc2BmPkSqTkK4DVpLgISwQ8KduL+HlH8FgKuLa0JsI2WtGwO4E',
    'Chhipaharmai': 'BBH0pxQy81zBrP1UnSlCjM0kB6T/C6GzPiTgF',
    'Dhobini': 'BBLk+xQ6/1zBWrE5O5E1MiH1M/F1GuPuPiLqH3D+FyIsHvB+JrV',
    'Jagarnathpur':
        'BBTkjzQkl2zBpNjL3HkHzOjFhM2b1L0E6MiJhE6K7JECwE6T2GoBpZyM6KiNXoC/FpMxEwD/X8N+BwGrG',
    'Jirabhawani':
        'BBSum0Qwn3zBnY5JuD/IhG1F4HiC4CjOhXvGoEuInFiGnPnBtDuYoMkE6FiNgE5F0HcmMwK2PiByBpS',
    'Kalikamai': 'BBMw8wQ662zByXnF5IsBxEvIrJiDrM5KjJ2DnH0XsM8J2KtFqJ8CxErO',
    'Pakaha Mainpur': 'BBHgpwQ8q3zBtI7IoI5WpL5CxQglB2RwFsK7H',
    'Parsagadhi':
        'BBSu+zQsi6zBjavSepGxL7BxCqE9K9Mvd5DwFoK5LsRkJwH0LK+EwInF+JsK4IuCrJyKuJmoBiMiCxjB',
    'Paterwa Sugauli':
        'BBRqk0Qm+3zBSnE1PhBlMvKzHb/D6FzE1KlQuEnHtJzGUHoXkQ3ByLwW+MdxGmKglB8F4CrgB',
    'Pokhariya': 'BBLwvxQit3zBmEvJrT7LpFmGiGqL5XiB3F8VwXgFmOhIzC3M6I/C',
    'Sakhuwa Prasauni':
        'BBTsh0Qwh5zBjStI3SOkHzJvNMxLvW7IsDvWhGjL0IkK4FvEoMwNdiFiN+ToBsFkL2TTdqGiX4S8FhgB',
    'Thori':
        'BBT252Q2vzzBwHjNrFoCzC5V7KvMjRu2ChmCmoB3D8P5H/BiG2FrDkJgYwHGpfiRmF0ElU+P0QoV2F6GzK+PnyC',
  },
  'Pyuthan': {
    'Airawati':
        'BBag+jRw+yyBnIxLsH1I/E0BnB5P7MrG5E7L7FiC2Cwf/G3ErJwJlJ7E3FoZ7R0atD0cmE6JnH+E6QyD+LpF4P/VmBvNgImNgU/B+GxXhIjIiL7R',
    'Gaumukhi':
        'BBTgspRgr1yBhBtHrXxL5PqC1LjNxHiFvOrKlErLlH+HlDkS/IhB5D2YiNiMmbxJsFuSnGuQgaqMwatWoJ/d',
    'Jhimaruk':
        'BBa02mRuk0yBxRzV3PrGxB2E1KC2B0HvH4D8DmFjLsGXyL6F+G9DiLiG6ClJgQgE2NoN2F0I/F8C0E6HvM6GqD8D9HyFyDlIhL6DrYgJiBmD5R',
    'Mallarani':
        'BBey+kRg20yBd3MpIvDoDzI1I/GkEpDzCtL6JrGuFrNvD1DnI2JzE/CuIpM7JhHnJ6B6JnSpFzDjGwIvHnD7FmHyBoQgFzBrH2IwJoJrMyUiI8HpF8RojBgaiGlBTvN',
    'Mandavi':
        'BBUsykR+gxyBsKhI/TroBgMtKjY5IjD8VhLtNhKHpOqb+H+J+BygBoFtB6E8LyM+FuDlGwJuCO3FuIpC5D9J0J7E',
    'Naubahini':
        'BBco+pR8i0yBrIrN/QtEzRpU1NtC1J/VxOkBvLhVrFiFpLzGrEyEhCwN3IqG/EyOqLqIvKuDjFkM2MqBsSsTqG5FgEsLwOsKqI7E8K+M8PpC0YiNuQxOuBpT',
    'Pyuthan':
        'BBgB4wmRqlxyB5CrGrPNxLkHlTpOrQkP5GR4G+M5JoSkJ5B4JuGlIuLgE2E8I7JwD2DtFsN7JqG2CwLjEqD2IgHpBmM8PxL7DlFwH3D1BzHqP5BsF7JwKtDpLpIgFxO+I1G8F/a',
    'Sarumarani':
        'BBa2ijRogyyB1Ex1B7H7J/J2DsBkK3ImC9LlJjLkP5C/DrRkDzBqKvGQ5BwIyRmM7C6OoF+LpF+FkIqLhGwN2PgQ4Sra4FnZmJ8EsJvJgH4EUtK',
    'Sworgadwari':
        'BBVg/mR8nvyB7OtKqEjBnBlPzHvUxQpL/CxKrR6KhQrE9OyP/KwkBkY6I/LuKkKqPL0MwgBmZ6JhHmPDO1SmR1PsBhU',
  },
  'Ramechhap': {
    'Doramba':
        'BBOyq7Qist0B1VhWvF5N/KqN1VuGkEqezPiIuBifzO8f4OqEiF1XsWyG+arcgP1rB',
    'Gokulganga':
        'BBZ0r9Qs230B9PxVgB9OzG9H/xBvfzTx8BjThVtclKhLhMtP6WnCsQ6XyPia0EqKoMY2c0HCoIuJsD+QyRiLqIqWgdHqGsQwPJ+ImK0BvF',
    'Khandadevi':
        'BBW0i5Q8mv0BgB3jBxN3MtCiEnGlE9MnPuKvftD3I5S6a/JipB7RkRsEgKvWqN+NwIL4TkEsBmezf6J+G5BsMyRtC4FgHwM3Z',
    'Likhu':
        'BBRis4Qm300BqYxN6IxNnR3C5XxPoCrQ0Q7VtDvH7TvEhKrL1PsU6C6PhJ6awFqL3K4LqhB+ToQyB',
    'Manthali':
        'BBe8i5Quvw0B+B5J3U1L1RqC+BnM5J9Gle0fjErBM3T7WxIGwJ3NqPoKiLqF3CX6KuD1DmI0E8G2KpUyQsDyT/FQegFwPsL6aaKlY6PhU6JsLkXsG6MvNXvgB',
    'Ramechhap':
        'BBd8h3Qmjz0B8ErL5bHvPrLd/EgGPrDxTqUxQ7G1KlIzErD4DW7KpF4C/N3LrNuVmC4LlJoBnF2J0C+M7EuJ5NgNoGiGvBud0LuFsM4QgczP0fwFkK3LtD3S',
    'Sunapati':
        'BBQ6z5Qu6s0ByQ9EgLpN1O0ChShG/KrNtQqK/I7C3JmoB+MoPoGmEsC/D+N+LuO9G3DncmErE',
    'Umakunda':
        'BBkBst/Qm040B+F/EzChHnJ7LpOzFzCmH9YpHpI2KnU1OvPKpGrQ/cIpIpWxRhLrD9QnItJzHBX1ctO5OtqB8ewJmSif+cgDsKmbyNwLgX2OsNmCikBqjBucyTsBkhBqUsJtFwV+B2E9MzBplB6KlK/BtH',
  },
  'Rasuwa': {
    'Aamachhodingmo':
        'BBV8mpRk0g0BgK1QnK7M4E1NhzB2a5QtJ/LyK/VtFrDkOvPsHrQtF3MyQmlBgwB2FvFwW8VoH5W8e3ImQ9R0IX5B5JkSzP',
    'Gosaikunda':
        'BB1BktqR+hq0BjCxRlWuBW5MjTvHhJsE5cvgB2dhFuDpYiPviB+BpelGza3LjCzSvVmGrS2J7EjKlqB1T2R/doInH6WvW7VpF6FjPxQjUhYjGjU5TwQ2EsMjDuLmK2UvB4ThImQhNgKwL4DkE4M2LsE4PujByUWgS0aIyO/IsR8CgL/RgQgOqPwG8lBwHqEGolB2NsNmajgBmhB7JwR0CkZ5K2I4CgH1H',
    'Kalika':
        'BBS2njRw2g0BmWuN6TvQtH1LjMTrKjJzECxIgWjF9HgDjHhGmC7CjJ9O0CxBodgJsBXvMiJ4HyKtD',
    'Naukunda':
        'BBO0okR60i0BzLxyBzOrL3R4DzJ3HsB2LrJT5E2ToLwIyDoZmNqHqSkiBmR1S2CvU',
    'Uttargaya':
        'BBZilmRw//zBzD1NvNjMjO3CvLpRzIsEhCwZ5btXzG2GnFkb7c5BwB0I+OzC8CkJ+FtC7CsHkF+HyI/VgPiJuI3BmP0XwM1NsQuFwPrHoCtN',
  },
  'Rautahat': {
    'Boudhimai':
        'BBOo6tQyih0BpFpanSjHiO1NnJpBF9G5H8FPxE3F2G3Did6MgMpC6S0R/MsIQ',
    'Brindaban':
        'BBaozxQ85k0B3InuB3J5CN0KjG1HjFmIlItFrFmGhM5QKnWhJnOxFGqBvJ9G5CjO8RsJuEZmOqH0CjNuJUgK2NgL2JhB8gBqciMb0JwLwIlE',
    'Chandrapur':
        'BBeg7zQ0mi0BH9FvQvC3F1GjGmH7M6BnP5JvKkHjHlHrM8FlD0IzRSgCyKtV5B5CyMyO6ZkFpGmIuFkFlIkG2HOzK4J6C4JytBzIgIkW8UuVwJrGvOgCrO8M1Fqb/1C',
    'Dewahi Gonahi':
        'BBSs4uQimh0B5DjPvHtDnGmGvHhFhHiIgC8FzIP7QoNnB7E7CoKsR1G2NwDb0IiQzCFlIkK9B4CrG',
    'Durga Bhagawati': 'BBJq2sQ8vi0BnJ7T/K8C9BkKxN7CjEoG0UqKuF8K4NvR',
    'Gadhimai': 'BBNonvQ+8j0BRvJtSlMoBrRnGnChPsICpHhOnB3H4KX+OiLkJ0ZmJyYrC',
    'Garuda':
        'BBQ0nvQo/i0ByBlFnHpCalOvJ5BgKzUh2B+JqDyOkJcyGwPiPrIoGmCnBuRmJ6DkC3LiIS',
    'Gaur': 'BBKgwrQush0BvTtM3J4F9ByQkJ0CiD6L8F4BS5ImK5BkCjO',
    'Gujara':
        'BBZu7zQo/h0B3FjWpnBlKxPvJzKzPjXwOnRnEnJyN0EoCxCsF3MAjPmOqV8csTB/BxK0RRmDzIsM7FkHmHwKjHoP6J8M5B0FnHoG4G4Q2C',
    'Ishanath':
        'BBP8msQsog0BhOpDgD1MrE5E7L+BtDqI9MqCvHmJducmO5F5BzEwHtBkBhGqM+C6SpO',
    'Katahariya':
        'BBV2rwQywg0B9GXxKoK5JtLzHM3ByJvK1K7JuBxFmEyNwP5FsKjK+BM6I6ONiB9FmLuD4R9PwMG6CxFzEnCgJpM',
    'Madhav Narayan':
        'BBR65tQ43h0BYnHxMvCnR0HjBsWvL0KkS6jBuUvD/M5JY9O4H3K8IItBlHhJZrDxOgNoBNlG',
    'Maulapur':
        'BBPu6uQqtg0BfzFjJ6CtH5KqI7P/IyCrClHnFwJlK1E1TkRoSkH6DmToD9FoLkEkT9L',
    'Paroha': 'BBNkitQujh0BjHrSvFZmC9S7b9EhD0MkPkC3F0OkKqR/BmHgLoNkH5CwFnU',
    'Phatuwa Bijayapur':
        'BBXwoxQ8sg0B2LhHhGzFhaiC/J7KQqIpG8CjC7O3FkN3FzJ9G0C9QzOnCuFhMNxHwPuH6KuJ1CgL2QmHjKoO2L+KrK+X0E+JvG',
    'Rajdevi':
        'BBOg1rQymi0BkEhDxD7I/MEnJiMrF7NjJzCrFua4JuEkCmLqHpDgB/J2H0GkNpT',
    'Rajpur': 'BBMgrsQ4qh0B7I/U+BjL/PkMpM9ChBgGvHwB4Q0OrCoP6KvDgH2EyLrP',
    'Yamunamai':
        'BBOu+sQ8/h0BxOlJjC5IrOwM/G1ExF+D8FiRyH5B6B/J+K7CkFsF7BuJ8JsC+D5M',
  },
  'Rolpa': {
    'Gangadev':
        'BBQwltRg5pyBhpBpPnIhOnL2BrFtQ3bwP1C2VxG+FyP+LuLVCuMiRxGU4K+jB2JwS3J2D1a',
    'Lungri':
        'BBQojpR4sxyBsS9Jl/BpnBM4RhImOle8KwHoPgK/EoL8UyOjB2JgW8MgC8L2KqLhf9L1SoFtI',
    'Madi':
        'BBT+4rRikryBwG5HlUrIN1KlRwGBtMtLWlSxNhJgdhDstB67BugB3E9N9ENuJtD9FjSlN7JuE9EiZgImDjS',
    'Paribartan':
        'BBUi2tRygsyBB3ZvIXxLvSxS+J5N9CxIsJnDwShchH2R6ftJ0DuK2NzIyWiBgXoJzF4ErN4PtJiQ8P8R96BwR9F',
    'Rolpa':
        'BBcgsrR4jtyBjH/IxOd7Z9OzV9S7EsVlNsG3DmN1MhDtF/UzF4BtRqpBoGkPkC/GsIiJuDsY2MwJc4P6GnLpBjT6PlFgdoXyF5CoboJgN9HxGpWUtbkIhT',
    'Runtigadhi':
        'BBZ++nRwosyBjEvZ1IwG9SxH+W9qBrK5F7F/MrgBnGrMoZ9CqazIoDkMmMrLoW6CgL/MoGxN4UiQsEuN/LqY+a8R7JoJiCqB/L2GHoJldiGxC',
    'Sunchhahari':
        'BBVwmsRmzyyBp1BxnBgjBr0B7D/KvHpDzM8HpT7E32B8Q3BkRqlB+U3XmQ2L0UnLofwGkKkZ2MPqJwXrH2CjR2TlBsLvR4PxI',
    'Sunil Smriti':
        'BBf28pR4vvyB+K9ClGnFxF6C/cpX5PoFqBkT5GoLb1PzMxJpCvV9HlLvDuG5DtMhKtEhUmK6G0QoBmPpEkBiQ0HxCgXlR2PpB6R0F+HyYnEuF5FiIlOP3R6Y0QsDzPgqB9M',
    'Thabang':
        'BBUgltR49vyB5KnU6BpIiF6CoC3EpTpSqBzKrH7LtLrD1amd8F0YoL6MrjB42BsXiPgI6LoW8JJ1W+Nra+C3XoNtK',
    'Tribeni':
        'BBTwlqRynpyBAlG1NrC5GhKpNG3C8HpmBoXtb25B+SyHgJjGoJwuBoQOEzKsN1GwDzUyKwHwG7hCkOrLOrK',
  },
  'Rukum East': {
    'Bhoome':
        'BBeg3vRspuyBRrF7NnD7BjMtJuLrWvFqBvQrOzGoGxjBlHpDnU4J1UumCuT0SpC0EhF5C5BqI8KqVpNyJ9C4X7NkaAyxBmXxVkX95BsXjdhEtLgKlC2ExLmJxDqEhTiS3F',
    'Putha Uttanganga':
        'BBpByyyRmwwyBnY3iBhI5VrmB6T1J3GhB1PlLxK3QyE3EuTlJyDzEwLhKoCiEuLrXkdZoL3IiHjOgfSuTqH8LiZwExPkhB6RqH8GvOmK/FmZsRgLxQ6KG8FiH2J3FwI9W6PlHjElUvMvGyHvR3NhJqCpToLqBoKvRuPUwHyK6RzL',
    'Sisne':
        'BBtB0wzRw1uyBgJvJDlI9YpS9K4D1ZjkBhPyCTkW/QuCrDmG5MO/CvJxJX/Phc6OnhBpFlHzLxChIiOrE4TgE6EtFjB/EgJuB0MzQElF3HsCnJ1G9D/GybsO0GsBgUkH7DyM8FuJtL8BkMoOwDuBsL8IsFcsPsJgH8mB3TiI6VwY4iB6ZzO6L5c7H9O',
  },
  'Rukum West': {
    'Aathabisakot':
        'BBrBml2R0+syBEzTzXnYhM4B5FpHvQ+BlK1GvG/PoD5J5NtP7FhTnf1axE7nB/NvGpWwDhP/G2HsK9DgKgJgK7DsMwIuPPkS6K2F8FuTsJyD2BhG8D2GtUyQxC25BuPpC2ZkkB+K3D4QkK+J2LtK0P0H6NwKwCoEvFyMwFwFnI6c1MJhQmPjjB',
    'Banphikot':
        'BBUmhyRkqqyBxBzH1BiGrJxD7FtT5K1Fnb0KpO/KtFoMtHsB8RyR2BoVvS0sB8MmP4CuM8JkBiDyJmhBhJkBjqCoTpV',
    'Chaurjahari':
        'BBP+rwR8kmyBxJvQsEvHplBvH7S82BwCsU/KydsQ+BwBpL4PrLtBrEsJiFoTna3C1E0L/V',
    'Musikot':
        'BBYk/vR4lryBGhb/ShSiE5RxUnPnCucvFNF6H7JoG5FlDqBubrPwNxBqI+SkcnByNgVgD9B9LmFrJsFsBvB9SgK9T6L2CiD2GuDvE',
    'Sanibheri':
        'BBa0lxRompyB1DvWhGtF8DrM/I/J+DhKlOlLuMrTjNlJ1LiZ4C2EnToarJhFuBsEhJqCjIsZ6P8FOsG0JuF9CqSuHrBqFlMuR8K+R3KwD2DwErI',
    'Tribeni': 'BBOy7uRwhpyBnErSnRdhIkO9WqF0DoLhJwlB8L0T6KUuMpLR7cyFoDiKpGuH5Z',
  },
  'Rupandehi': {
    'Butwal':
        'BBVo+9Q+38yBjPa9L1IlP2EpQ7P4CkfhJxGnByM/HZrI6HySyLoNPkE8Z7D2F4S0BgVzJzFtHuB3T2JtH7CtQ6HrI',
    'Devdaha':
        'BBb0w9Qi++yB9C3JjRsJtMpFxKyMD6IlPoM5EtEjWoF3HvD8BtH5SrD/FyDnCsP2NnBrF4S4D0EwK4BuBxJsY7E2f4jB8R8BjDhHkK5LQtP+MndHzQ',
    'Gaidahawa':
        'BBXki8Qgv7yB1BhQhXsB/DsGsMnbnKkGYvM9SpD8C9HmUgCbxIziBzQtX2OqM0LlJmEsKsF7E+dgM2BlEsJwd3BsP+HqEjH8OU',
    'Kanchan':
        'BBUs78Q2k6yBIzTjdnEtT2FtC8KtQxD7C8H+SqDZwMqKhG9LwbuDxG6R9CyFmFqRjMyD9F9H1J3HJqBjF8SkD',
    'Kotahimai':
        'BBSg94Qo07yBvCtI5RlI5E/I/MgDyB4UlRwHgIoNRgSwQrGuEsJsLiCsKxM1I5F/GpXgIQgE4MmH5M',
    'Lumbini Sanskritik':
        'BCYo85Q476yB2CnVrKrFmJlE5IrLhNmC/Q/H3GqFpPxGxIgJhI7I5OiZ2GmTgNb6B0HgN/CyS+PqKrFqHgMyFhIoE0CY5HwHgB+BjJF5U3QH4JhbbI3J6aO',
    'Marchawari':
        'BBR2x3Q498yB/GzevJkE9HpJ9E5WlMrElIsDxD9IhDoQwEI5CoMwGwN4Q4J2DqIiJ/B8NuP4EpF',
    'Mayadevi':
        'BBfys6Qo17yB8CzDxNjC0D9J/QxCzC4InEzCxFiIpH/LjGFkCiU1G0IrE1M/HP+GqX4I6FhDwP2IrJ0HoDuLwP9G0H0JmNoEInB5WhKlasSkGVxHuH/D1HtCXxGmOxK',
    'Om Satiya':
        'BBW6t6Q2k+yB3EhG5JkBpE7J5H2R0IyJrB8FpSrQpH8G6CqRoGjB0JwTzB0KqGNzE2PmNyMsHtZzNsBG3ImJtKiBpb8IlM',
    'Rohini': 'BBO015QkigzByC3GrGO0BzKzJvTnGkBmBzNlGnMrKiK1Dk0C0MtCuHhLqQOY7T',
    'Sainamaina':
        'BBXyn+Q8m7yBwDvGvH/X8GxFvKtLgInHrCvI1oB2IgCkVnQzFxJkEuQ0MhWiSkD8LpESwIqWmNsPoP1E+L2IkPnE7H1J8SxW1BlN',
    'Sammarimai':
        'BBQw43Qgu7yBxBlW3PxB5FxSzGuJpLjE9HsEtKyM8CmIgJpDsLqE+E6WgJ6JsEB0BlLkQ1J',
    'Siddharthanagar':
        'BBN275Q8z+yBrIxL2BzKzJ/J2GlJhT3S1IuJjC6tBoMnKImEwJhB2LmP4F/C',
    'Siyari':
        'BBY8w7Qs88yBnRnW/IjBlI7QhQgMYyG2HuC7GiDEwIvS5FoGoG8DwhB6ETwH0MwNtC5F/HqC3GhL3B+CpD2I5GwQwF6DlI4HqCmGvI',
    'Suddhodhan':
        'BBVkn8Qsh8yBzKjUjK2BvD4GvP9H/P6CoHuUiPwG+GmQN1F+EoDvG+L3HpC5DmIkM8F+I3HgIaoBxMiJyGrFrc6FzF',
    'Tilottama':
        'BBTss8Q26+yBZzenNQrWjPpZ7H1LkKgL2BnC6G6F+HzMgRjBkf2F/EsJsDa6I+LuEwQlGmGqEkPlM4G3S',
  },
  'Salyan': {
    'Bagachour':
        'BBX0rtRu/oyB1CvSnLzRgG7Q5axkBnQmBlSwY1ExJpFmDnE0LoG0FXgL2CiGgFzFuDyD9DuTiEuQoL3BoIkO0pB2N0EvKzFvFqG3H',
    'Banagad Kupinde':
        'BBoB8pvR4ziyBgFuB/E1HwCzJ3Q/BLtNhL2E/P7K3gB+UxetKtE9MnJ3CKrP9NOvSuRzM7IrVoSMwMkH2C0E0SiQmC2PiQ9EiI2FuIvC+JqIpFqCqIqI9H2EqFwEtSiLwIsQH+S4SgLL6DnMuIY2ElI0dzBdpR+K1R',
    'Chhatreshwori':
        'BBf4orRy5nyBrD1DpFuFzB7QnGzFgD3G7M/D5QpW3H2D7IlFsK1I3HrSnM7DtI6JxJ3BtCsckFoKwIpI8LwF3H0PiNmVDuItQ4OwIzCyEiN8aiM2JvMoJoByE3HuInB6DzT',
    'Darma': 'BBM8wuRqunyBPvOzJ5ErVpJrbG4F+TgI4EhG2QySmlBgStJmKxQsE9X',
    'Dhorchaur':
        'BBTw4sRy6kyByN/Q/NnG1GtK/OgBlNpIpCkW8JqHlLySnJ4E0C8N/G4BmF4SjI4KuFkMmSvYkR9BQne4N7K',
    'Kalimati':
        'BBoBgxqRqy9xB5EhR5rB9OnMya/MiE2FqJ5G8V7NoNhHlCkDyNtKwWoDkMyJqJ8NhNkI0K3Q4M2BiJvJzFXtHhM4FpN6fmZ2S9CyJ2NiUpDuRgQ6NuP/E0K6DjC9JsFKgFpMyGQnGvLsBxayKrNnHzDXvN8NzO5Pzf6hBxzC',
    'Kapurkot':
        'BBXmqpRw3oyB5B/MnFrCvDmFtE7EwH5EtGnKtL+ErHpRhTvJbwK/NqHG0PhVuSLiQ3MwCsgBoG8FgNsKiG4JhVihBlR4C7HkGsC',
    'Kumakh Malika':
        'BBR2gvR2rkyB1CzVjJtCnT2E1EmInIf/DwM5LAza8aKkmB6U2HyS7Cse+NkHzjByJ7L9GrWiGvO',
    'Sharada':
        'BBjBu7rR8vkyBcrFzGoDrHnP1GgIjErIjI2FqCpK1FtIiF5H3PpQrPvB1FrL1JmHtB4aqGqLzGJ/EqMrFJwCsJvE+BuDoU0L0C4HsSvKmHmEuFyMtC6QqWiNqE2NnVnFzSkHpCzC7NoJ3E2JxR',
    'Tribeni':
        'BBYstpR40nyB5M9V8HvP9L1FxIsItFjL4CvbwP/BsD3U1JtJ9P+E/P3NpKsJgJiQrFqSmE+LpHsQ2FiZiTuJsHsRqL9EyGoK6KlHFnH',
  },
  'Sankhuwasabha': {
    'Bhotkhola':
        'BBwBwlgR6ru1BmC5L7NtKmCpchPlZqH7coFyRyMlI3K/b9KjKpB7YiL7I2E/alHzNpMhItBhhBrUokBnC6XviBuXnSnN3PwFvZumBCiP8J4R4QsLiJwT4BykBzQzBvH8LyEmI2YsK1D6HzKqDqD4GvEmJwXsKjB+KiNkBiMiOkHjE0R0MqM9H8PiDJhV9OlPmG3NoU/BqFrJ',
    'Chainapur':
        'BBVu41Qw7s1B6a/V0V5ItKvH3Qzf5TxPxQ1uBL9jBpGpJjRF3B1H/KuD3VoWkSsRwIuYyU2cwH2ZgC8YjT6mBsRkOgStO',
    'Chichila':
        'BBOg15Qi3n1B/GxVlQrE3ExP7M5L9Bmb/H0GuB2PnH2IuGubgSoJ2VJpDxZwNlP',
    'Dharmadevi':
        'BBS8p0Qs5p1B2H3IvQvjBhSnRlMsFlJ8IoIkP9E+Q4DihBxF4GzHlBpTqUoMNyM2IoC8TsLwLiF1Xqdh6B',
    'Khandabari':
        'BBO0q4Qwqm1BnQjU7TpBnfgqB3WpGrI6L9T0DuZgEiNrHiS8Y8RjE8LqOyTrCuMx6B',
    'Madi': 'BBKqn1Qy1r1BnH1tBvOlV7WigB7CsQlMiSzC8V6KE4gByQyS9kB',
    'Makalu':
        'BB0Bo/hRuyj1B7C9VvSrBlIvIzlBuO7M1I/G8UzO7Q1ZzC5MiMzDwY7J4M1bkXlVgJpXsdpIerP+RrKhNtK6BjF0PoJwY3NuOgEkdzH8G+GslDgWqH8MrD8TsT5CkKwXyDyDsGoInDqIvQ0Q0BlErrB7gBpoBNxQmGpDgC3N6XtYuJrCiSmNwiBtXoC5XygBj4BkC1P0VtFoF5LmUnG8GxP8O9I6BpM',
    'Panchakhapan':
        'BBNuj3Qspp1BsIlKhXxUrXhkBxa0DkGmJM+jByQ2uB6TyP4Q0fiKyG9InsB6DzlB',
    'Sabhapokhari':
        'BBQik5Qkqp1BwG5J1VKvQxHzF/TnU6C7LpO1QmD6KySiT8PrImK7DkmB+IosBuIsG44BuKhG5hD',
    'Silichong':
        'BBf4w9Qo4j1BBlMpY/MvZpCzZzSxUJ5G6HtMQvI1L3LlD/PwMnPnOtO4rBuHgUrEoJ8LuJ3C8NiF8IhK+TwRgJiNqYwKDkFzPsHjCuNsNsP9R+KxD2U3amV/IibvWuLxR',
  },
  'Saptari': {
    'Agnisair Krishna Sabaran':
        'BBRq1pQ07/0BiC3RvQndqInHtUyKjT1D/hBuEuE4T/H2GoByK8WuCmM2MgS/BoHjJgGmHmClIoNgD',
    'Balan-Bihul': 'BBH+5nQm350BpoBxRnJ8kB2N4D+JjIqZtBSjN',
    'Belhi Chapena':
        'BBOs4mQ4q90BoCtFlF1D9J+BoDhOxZjFjK9MlNrFlLsqB+UwIsHhM4W3D4GkN8LhD',
    'Bishnupur': 'BBNm4mQm/90BftRrNvB3C5K9c4HzDiTmRsFjIsO6IuCqN1I7IpVqVgPiG9D',
    'BodeBarsain':
        'BBQk6nQkn70BhGjLoCjWnWI/JkI1N3DnVmMhE0IyOGoD4K6HwC4UjCSuHkO1F8IoE+E9I',
    'Chhinnamasta':
        'BBO41lQ0m+0B+B/ElRrFiC3L/HIlFnH9P4BzB4M5HgG2D2KqEzB2K8M6V1CgLrK',
    'Dakneshwori':
        'BBPilnQ6h90BgBlN7XjM8C9K4LrCoCxPrWkB5HvCnD3KhNnC1MokBqR8OyZmFlDiOqZxB',
    'Hanumannagar Kankalini':
        'BBW+knQ6lh1BhL/ZnelFd5H/H9C7F+NrFdxJlP8E/EzBnN7K7J7JohB0LmR2CwUkPpByJsPiU2KsNwY9D1TqOrCNxVuFpD',
    'Kanchanrup':
        'BBXs3pQu7/0BxP3ClCmI/FlHnHkJzS4BpQ8Q+DoEtJ8LpQwCHoXvOgD0MmdqWrrBoWiS8W0BmBtiBqGzK4O1EpHhDpG5O8L1C8B3F',
    'Khadak':
        'BBS6tpQ0u70BBpHvS9TxQb1SzJ9DkTmEuS/UYtJyO2LiIoHzCc8E6RpH6dsP+MGsEnO9FxOiF7E',
    'Mahadewa': 'BBJwonQ+m/0BhHnI5b4F5GkgBqRwGqJrC8J/SnBxKsG/D',
    'Rajbiraj':
        'BBQ4pnQ0k/0BItOrJpFwE/HrK/OzIyJpV/O8IqV7N6ItNxEhDyQ0FwPyOWZ5G6d5IsQ4F',
    'Rupani':
        'BBR82pQuj+0B1CvH3TsLxX7E1CtPjLOYxIvTBnJvJ3I+OiCkL0I8BkE0LvEgIgnBzEkT4D2brM',
    'Saptakoshi':
        'BBOmoqQy9h1BsQ1GhE/ItMqBhRlQG9I3O2EpK8TgHsF/DwTjFSsb4UsOtK8B1T',
    'Shambhunath':
        'BBUy1pQu790B3BpM3LhNmKxMzGxErOZ5drPzRqHhB7EnH0CvUjIpBuOsWwII+UwVqBbuIoLJ2CuPyX8EkVxL',
    'Surunga':
        'BBTunrQy260BzCpYvPnD9JoFnNnQ1P4EvZpHtasHhB2PzLiCitByM8SmU2P5L4KkBkE/MwSiPuFOlChHkFpB',
    'Tilathi Koiladi':
        'BBPujmQqn/0B/IYiB2GxOVzFvPsDnOzRmC7CiLyLsM7D4PwL2Q0ItO2I8C8CoI4F3e',
    'Tirahut': 'BBLggoQ2pg1B4FjFxLtMnY/CvIyTtGyCuKmEwJ2a4P/KnBzJgKhL',
  },
  'Sarlahi': {
    'Bagmati':
        'BBUmmyQi7l0BsFlE5JZ9ezhB5NLzUzTpHoSvH0B1BgJ+PuB3J8QyN6F3CqH2J2GN4GsbqEsB7H0G0JwTuB+ElW',
    'Balara':
        'BBUm9rQ8qk0ByFrCzJ9RDlVqH9L7PpH1KiMjGjHfgKxIuDbpL5JtE9BoFwN+Q5C+FwNgS0F8DgLpGbuPqKb',
    'Barahathawa':
        'BBZyhwQ46l0BiCpFxN5F4J7Q/PxByQ3c/PnKxOsJrSnBtTshB0GuHpEiH4IoF/HiLiJiEkH3F4S2JsJiMqCtG3JlEmC7DqIoE3GzHmCxJmX8E',
    'Basbariya': 'BBMksuQkmk0BIxIxUnHhFsasD4PhL+SkNxDGsJ2H6CwFhFzJ/W8PhZ',
    'Bishnu': 'BBLuysQmwl0B3KxL1QDdxJhP5FxEqL6GgPmGsBpDgKwUmFyRrP',
    'Brahmapuri': 'BBK2+tQy8o0BlVxe0K1FVlL9nByF+NqVgUkKXgMkKiD8HpE',
    'Chakraghatta': 'BBKm+tQugm0B/FzQhZ4BxDyW8IkEEqLkQgBgFzJzFhIkKnG',
    'Chandranagar': 'BBM+3uQuuo0B8DlCzHhJgBnKsGvFtHjNziBhB+CqS9KuGsLmUmQqDiS9G',
    'Dhanakaul': 'BBKm1tQgnk0B0C1QhXkDvPle7FiSmHiK0FijBmVkKsHrCO1a',
    'Godaita':
        'BBPo4sQ2ul0B6S2EgF1PvTjG9ErM9QjIxR6F/B5RlKiC5B8V+O+FeyJ2QE+G8J6IL',
    'Haripur':
        'BBWoqwQ2wm0BoJzFrJbM5G7KrH3V7ElCyJ4G4HnIrEnC8D2JqEnCqGzG/EvG6OxGlFrDyPwE4J4K2KoP3G6SyEtDha8HjO',
    'Haripurwa': 'BBNivuQ2hq0BvDpNlDwE1PxJoL5IlGnIrRLvR4NI6HgUiN8JxCsUqL0BjH',
    'Hariwan':
        'BBRqlyQ83m0BmB3F/Y7BrGxJzB6HnQ1E/QqKNmZoIrHsJgCiN8nB2S+BqJsH4F9DWplBpE/F0E1R',
    'Ishworpur':
        'BBW0vyQ6hs0BpK9TnKaxpBrZ9iB55C/KJ/H3HtH0PuH6KvW0HhKxD+IyUnL6I2PyJqDrEwCsWsyBsN0X4U0MwDyBgH4Z/CwPuN',
    'Kabilashi':
        'BBQ+jvQ0um0B9BjI1S1JjH2F7PtBzDwX7MrCfgWkNwBlB9IsIqEkFvFiUmDsDzP2GkFuFvN',
    'Kaudena': 'BBJyjtQw3m0BcnL5IjE8CrXrH/DpWmTrKzC8B4FkrBsU',
    'Lalbandi':
        'BBU+hzQuwq0BiDnH3F5PtbxjBpHgD3cvMpKrkBrJ/BnIsH6B2LtW1CqG2e2RmdiK4iB8IgJwemLwC0FmKb+J2S0S1vB',
    'Malangawa': 'BBLoqtQgjn0BtC5M3KG3kBpTpB4G+OuOvCyG2Q2NtBwEkTnFsEvI',
    'Parsa': 'BBJmutQs0o0B3UrM2BuJ7L+EnG2XoNvC6EyEsLhJ4HvS',
    'Ramnagar': 'BBLizsQiqk0BLlSpHxK8FhSvJkGtH9LnH8LYyX+I0PgQ8GIhF',
  },
  'Sindhuli': {
    'Dudhouli':
        'BBjBs8xQo600B9CjQ/NnBnJ/Q5SyG/GpRkKxMStO4HtF0DxcsMlI3EtM5JKerGlHlChTqTnF9N9GhDd2e5V+2BnfsqBpI2C4S8O+I2TW4X6pBwS6D3JqKpCwH3K+UqKqErNzEpLiHrNgHtB0EzV',
    'Ghyanglekha':
        'BBZ2r3Q2sq0B1CnJnN1IhNnDpIuG/KzNrKiE8JsQnIiDtGof9GgFhDuNqHiEzByLpOgIL6GsCiPyMgIyPvH7BkTmSxZzC/QkJ7B4VtmBiH3a',
    'Golanjor':
        'BBaq+1Quyv0B7PjXzHoRZjI5S9KzGyU3HqEzK/FsCiOzJ8YhKyJpD8O9G6B8K8bnKwOgTyR4EiMyRzOG9OnG5E2SzW7C9K6EjL8J9B7BpMmfxlB',
    'Hariharpurgaghi':
        'BBlBw12Q82l0B/CtKvMxPzIfvClNlHtEhX+LhKkb7d2EcgKhP6DWnNnHkC1DrHjG6FiBuIvGEjF5I7GmH/B+QqFqFrHyVqEgGPunBqN1DoM6H+QnMsP0HzC3MqFlNmhCzBjD9Y6KjQ9D5LqEzGmF+DgG1M',
    'Kamalamai':
        'BBrBo41Q4qt0B5ChEjNsI3MhIpChVsOnIpClQ7R5EjGuGhO9HhWuItUnH7Eoe/ItDtM6QgM6MvPqiBtS8DzHmLjhB8Q9E0mB8G+CoF+N0P5Q8QnH+BhQgJ8KsXtUsV8RgDkWwI8JgVpoBtBhS0KgG4HpE0GxU6S+KWiIwDhD6FlVvDzGqJhNsCtV',
    'Marin':
        'BBZol2Qq0o0BlDhZ5PtBlU+F/IxE3WmDAuYrPzH9QoMnM5HpN2DyZ+fgH+R9NivBoSsD+VtIiO+HkGtG4O6EuQ1xBoIhD9JnQ0RpGjHvS0JnH',
    'Phikkal':
        'BBVut0Q8800BhOjXmJ5exOgPxV5D1C+K1N7HnFgX3M6J1F9BzCuWzKiKWyMkXgLhE4PyY2NqI3GgGjWqQzB+F5c4LxR',
    'Sunkoshi':
        'BBRyj4Qios0BtGlN+C1Hlc5KrV6lBjJ8BgC0S7a+qB+B2NyOkQyVzD2IlHgDrGvFvG8RjRgKhpB0OtQ',
    'Tinpatan':
        'BBfyyzQozz0BJ3J/SxRoKvOhB7LtHhBrC7OgI7GvI7J/CjWrV7RrXuUrIrL9Jud2JJiF8MrMmIzDyc3HuFRuO9J6K6GiTuTrGqC2KqUsHyHiMoR/O2B9R2N8H6C/K8NiB',
  },
  'Sindhupalchok': {
    'Bahrabise':
        'BBXyohRiss0BzOrGnIyI/JvBzB0IjcvLjjB0SiC8NgJsImB0rBiHiLlFycgQ1D2MnL/B7erH5GdnP0J0CqK/RqMEgN1VuP9EmEtL',
    'Balephi': 'BBLy3/Qwwr0BvCjJjdnGjiBkL8S+8BrBrNigBjQlGjIsDpTmR6JYlI',
    'Bhotekoshi':
        'BBY66jR4gu0ByCtI9ErG1FiEzMtMlFuEjchMnMY1PhX7E0MtP+E/M2V/LLnKgSpKToCiQsGoE8Bsf0rBgnB4JhgBpClIyStgB4iB4RmgBnmB',
    'Chautara Sangachowkgadhi':
        'BBOw0/Qsmq0B2O1UniBpKvkB+FzY/E5nB8VkJP6DmM6K8D2a0d4HgB4hBnLiYmFqE3e',
    'Helambu':
        'BBbq+lRmum0BnD1OtIjIxUVRnK9NrTrQ8WrQ2LvXlG9M+C5HrIzVyFlU9GjXuEiO8yB0uByfyFtB5B3O0WpNwOyBoLjGkL4F6G9G2F2F6clC2N7EwJhS',
    'Indrawoti':
        'BBQ69/Q2sp0BoLkH1FzNxFeZxM5Ppd5LsH1DpXjJ5Bnf4YnI8ZlJmKyYgFwkB7FkNqGyPlB',
    'Jugal':
        'BBwB04mRojs0B7BpK5NnNFnlBpH5DtDrTlHA3YqUxKzIrKcnc8RvX6DzL7LlF+HzEjF3MmDlQvOpSZrDlH7IFzNgNxEyNnC6WsHuFAyM5ShItD0SoG6I2e2J0BzIgKwBkLhI6TsM+HkQoMXkciMmFtE0MuMgFlE0FwGgNlDsJsE+M1D0IhR+MkBmO7M0K3BgHtT',
    'Lisankhu Pakhar':
        'BBR8y9Qmtt0BiJtIpJzJ9SzBtHtTjLnFrI6FnH5CnLwP6BwPxL0K0Q0QyQ4E6DmNoW5B4BnWoNxK',
    'Melamchi':
        'BBVgrgR+9n0BwQrMtQvUtJ/pByVpE1Y5PvUzB3YoP0I6lBjRiU9FdmB5I5EyC7Cmb0C4D+UzS4IWuEgY6KtIkR4e2Nxc',
    'Panchpokhari Thangpal':
        'BBlBglmRs9m0BLrLpG5D3J2S1N8E5cmC1F1F5G+GjL3FnLkGvOxBzWqN6B4OxFuB7YzS9JpBra4ZrD4b0FbqNkWqSamQwO4MlD0EkFmF9H8I0LoaxDoc7RsKbyK0IoHtJmZpL3DxS/NpPgS/P7C/KiJ7T',
    'Sunkoshi': 'BBLmj+Qs6s0BE7NvNngBrHbzdld1D0yBkLoF4H2T0SsB4I+J4HpK',
    'Tripurasundari':
        'BBP22+Quyv0BuD/IhHhLlBzrBpQxThc4Y3BoWiXsPnEkKmGkR7BiQgJsC8J9IiH0D2BhT',
  },
  'Siraha': {
    'Arnama': 'BBM2rqQu410B1DvP1PpJxuBvGvCyGsIe2JwP6SgDD+GsM6EyThCHhE',
    'Aurahi': 'BBLglpQkv20BJ5GvOxEnClG+EIuExNzPhR9SrGwCupBoJ6HuemF',
    'Bariyarpatti':
        'BBQ28oQmh30BrFpO8D0BHhJtUrBnJ5H5BmL1GtCjIkjB2DhE4KyEgIsLnCrRgMiE6DjOiM+C',
    'Bhagawanpur': 'BBI+9nQ2l50B3GlJyB1IzY/QvO6iBgZmMoQrEgCtH',
    'Bishnupur': 'BBI6uqQos00BPpG1S1M5CiVvHwG2ByIsVsQsGrhB',
    'Dhangadhimai':
        'BBa0xtQoz30BQvN3M3F+B4JnGqFthBoFvLvQjImC+ExNnHxGlcvItMiIzL4pBsRqKyF/JsV6CgFkDvB4KuH8C7C4E2kByOuFwIuG/I8KFBtQoM5d',
    'Golbazar':
        'BBauntQio30BhChIhKpFwEnP9Q1FxY/lBvHkEqH4GgBiO5PpIxCsFna5HtD2GoFqBL8GxTiCuIyC8G0N0G1FkbqIuH4G7EyNkInC0LyQqhBnFsGvG',
    'Kalyanpur':
        'BBVw2rQikz0BN3Ova/C5LyH/BkJngB8NMoUmHoHiD9O+E2DtB7H2S2MMiKiTyIuL1ZnErE4FBsBrGxPnK4G1FmPO',
    'Karjanha': 'BBNu1tQu6y0BgN1DhQtOrcgF9LyJ/TxBIsSsXwLhGgF6CqKnF6K4QgDufz1B',
    'Lahan':
        'BBZoysQwr50B3DjJ1kBxO4C/EnJrIuD/E9HxEtSrBnFgKzQlI5C6E7OQqBwQjMpDhH0MgB2Rwa0G+PzEgNkQgWpD+V+S6MhBtCjUqHlB6I7N',
    'Laxmipur Patari':
        'BBPq2pQ2130BuDvDhIoBxK1MhV1IzEqOzM3D7BwEyEuN2KMoKkXsNqBxCtPwQ7BuCnM',
    'Mirchaiya':
        'BBSojtQyt10B/KrblT/EsF1K5CpKiG/ElXvL9S/BtDyF+PqJjH+FoEsE9JiV4CoHuRsF4dsqB0KQqDzd',
    'Naraha': 'BBIo2rQ0310BD/M7GlJxgBtRnE+dqa6HyCrF2OqH',
    'Nawarajpur': 'BBL2roQq340BcpEhP5HmH5MrJxPzT/BxHgW0YgRxB2IiHmJuNnO',
    'Sakhuwa Nankarkatti':
        'BBN83oQo040B1JpZ1KLjGmQmPoIrByI1FjBnLiMU+G1NoFsSqDqSjF6Fnc',
    'Siraha':
        'BBV20pQ2w00BkErC1L1LgC/T1TyC5J9QhIxCfrJtH2C1KvF4Dyc1MkC3DyNwB2KoQ6KXyFwM8GuCxGoMRwbmGoD/N',
    'Sukhipur':
        'BBP2nqQiv20B7GzN5UpHdxHjMzDhG8O9EH+RsNvO2HwE0RoLwC0K4M0HvB8G1emHjE',
  },
  'Solukhumbu': {
    'Khumbu Pasanglhamu':
        'BB+BmhlRug70BnChLxJ6C3IjFxFmErLnKLpIte7M7jBiDvIuRhOqE3fLtazI5G4QvV9BrJuFc+Qld0S/BiYzQqHhL8PpcnGvK0EjEwKyE2G3ImCzDlI/EyPybyJvIqRgMkLmzBmJgP4I6G+TyL4CsHgNsHrB2CqG4pBnKkM2Q9CoJmHse2R5DmIuIwSuBmIjf6PjF+FtWuR3NwBzJ1HjKoCxc+LvKB3M8H5DiPqLmSzQiD3e1X9hBoDxQkPvCuGzO',
    'Likhu Pike':
        'BBP2s7Q6k50BpEjf1OrN1LlXna5MpGmMWsQvSwNhBqKiJ3C6DwL+cuc6KxDoM8KgRxP',
    'Mahakulung':
        'BBoBitgRy5i1BpB3qBjM1Q3pBoK1CpGrHsBrH/M/KlClDvQ1MhKlzBjJ9OnN/IgKnP0B9M5H5TD7Q8GwGgOjH4KpD3I/f0M/CgMqImlBgV4KoFqJgQvM4LmDwI2LuMP6G5HmUGga4SwZqCqYgNmPpS2Z0C0O8QgH7U2L4IuQzG',
    'Mapya Dudhkoshi':
        'BBWin7Q03+0BiFtGvXlEhEjGoFzO0DmI4IlCtElFyCvK+LjGlR/LhOa7D3dn5B/NrG0foUkVxKiUsduV6a4GmKoJqO+CkDpJ',
    'Necha Salyan': 'BBLop3Qki70BrLvdtOiSvPgETg2B0IsN4HC0DtQ4UtSzE/M4FtL',
    'Solu Dudhkunda':
        'BBfgk+Q6r70BvE9VtetOlTnB9iBpcvPqLnM7K/OiBpZzanD5KzciMxFiI1K3BtEwFoDoR1XyV6L+anG2OqEmSgQvN4lBzBsXuMoU4B8D4diOZiSwM8a4F0L7PuSpJGhWydlT',
    'Sotang':
        'BBQ+94Qgu/0BqWrH2OWkLuH+PpBmG3KzzB9S3SlRvY5CiH8VzQuTnBgjBkflKqD4IkH3KvG/N',
    'Thulung Dudhkoshi':
        'BBT+54Quv90BwDrK9T9TqFzchXxBVmFjR6FzS4PxEgOyR+FkB8pB8KuM1C8KiQmQkD3QyPzQhH7V8NtB2GrK',
  },
  'Sunsari': {
    'Baraha':
        'BBb2+sQ4vm1BtFtJvhBzG/lBhXvGzZuHnNpVjShN8dhGZnIuJjfha+E2PpEsJsLwEsJ+RkiB4YwG8LzFbvBkLwK8LiYgF2T8MwDvSgUqGyGrIyJDgHtT',
    'Barju':
        'BBTg9lQw4m1BhOxPjQqL5HnDjauKVyPlG4E+GqQ0YoBmKnFkKsEiHtHpIhIwBjJ2JsB/BpI8KvBxE1E8EhC',
    'Bhokraha': 'BBKm4oQmpl1BpJxPvN9FrgCkFR+K0JjBgFkQwJ9D+IsL22B7Q',
    'Dewangunj': 'BBNm9lQmtm1BSzGlKzFlKlTnG0JpQMrGjNrUmeToUyfhM6HoDkQpLmOqE',
    'Dharan':
        'BBVq9sQ47n1BzHxMiBzL1ICtH2IjTzGvDwShhB9PhKgXzKqG4CmHhGiHgQwElIgd2RkF6VnJwU+PwQSsR1gBtF5ZgG3K',
    'Duhabi':
        'BBOy9nQgvo1B1lBnoB9RmH5bjGvBkJqIiI5G4HsUiFuBhFwX2X6KwEsKzD2KuGmGnQ',
    'Gadhi':
        'BBRqjoQ6no1BC9SpHgFhHxF1UxsBjclFnGgLnKZmKgK3F+DyE2E7KwBgCqIkS4E+RlHkdsgBiOQ',
    'Harinagara':
        'BBQowmQykm1B/FpO6FpMjGrHzJgBW3KxtBqHnIgLkENoDgNyQJoGzJuLwUuJkF+F5E6LmC',
    'Inaruwa':
        'BBR0voQ+5l1BgIrHrKvHxmBwP5O7LzNyHwH8O0O2C6Mkf8O+SqH/E+CtPgMgEhBhStK3G+C5TyFvC',
    'Itahari':
        'BBU+iqQylp1BgEnNhQrDiGtI3Q/epK+E7M5IyB+EhG+CvD9J3GhClFsVmDoKnIO1EmakMuD+UpJyIiL0dmPqElO',
    'Koshi':
        'BBP+joQqtk1B8DxB1E7PrmB9a5OtRvGnSncnSaiQ+Q4B0J2zB0W8Q8LuBXyTmbnBMtH',
    'Ramdhuni':
        'BBW8pqQmtn1B+ExE1L9CrJnLwBjL0FcvG7LzelY/IG+EqG9NmK9C6TuK4GbiamG7CxB9E6M6ImKjFqFmR6IsH4KzG+E3R',
  },
  'Surkhet': {
    'Barahatal':
        'BBpB6myRi73xBoI3H9JtMsBlHrG3CiChPhKnLpDnU7GOOwOzI+LzI/I3KkG9HxToDvVzOrD7BpQrK5GjJmEtSy0B9L4OzRsI5DyRrbwnBimB8KwJtIgNqIsCySwJ2B2E/F2QkL0I3B6HiFsC+O6KtJqDnQ8W9RApQqJ2I6NtLPlI',
    'Bheriganga':
        'BBWsmtR+j5xBmZjOhlBhKrJ8FG0L1xBm/B5CoS5U8b1EyV4MyHM4UgPiDmL6LiJ5FoE5ZySpWyGVkOpb7E9ImEnkBvGjVsO7S',
    'Birendranagar':
        'BBXoswRir6xB7DxYhQzCnQhLjF+FvJ1BrCxS/MpIvFiIxd2L7OiUwL8xB6Z7FmiBoG3Coe7IiK/EnDsRgMuE6MqU1uBsIrHoBzf0I5E',
    'Chaukune':
        'BBtBm71RonvxBgEnI1PhRsC7LlL/M5LkZ7a+SBgNrHKpBoKpLoIqE4OwI+B8E+I9R+I3I9C8CmNrLqSqFiC8ElHyRsCasExJyB9K6P1HzC1E8HlJlKjJqNjMBtMgI0bwrBiauF4EnFqHkIqakG0LjK0LvVxCxL7L7K6H3M3F1FqBnUsIjW+atgBmEriB',
    'Chingad':
        'BBPu/wRqj+xBhClFnbhEhvB/mBnSgKwGmbxZyT/FwToP6IqJnE4QkE4JmXuW1ZqmB/T0HpN',
    'Gurbhakot':
        'BBT0rtRm3+xB5InOhtBtO5CwM1HuE5L9L7P7EtgBisCgJmYiHyHqO/CyFkIwStR2MyC2B3NiX5LwT3dyJrCsDtL',
    'Lekabeshi':
        'BBX+/uR8u7xBzDlJpf1DlWoH/H3GvE+N8E+IjOqbxGWxSqWlC6OitBuO6GyK4dlbtFpG+E1EhI7IgCrHwP7FjB1K6EiEyIxJmDtX',
    'Panchapuri':
        'BBlBm00R+q2xBkDjHlPzmBjb/FpHjI7EoF9ZtFzbvrBhHrC5BmKpO1DzFmJ1NyCpGgd0JuN0JLnDwV+HyT4KjG0IgJ0I9LNvOgIsBmCuSiKoLhCiPsG4CrBmH+JuMnI4HOsI6KgEmLjPqM5E4HnR+YwB+JtY',
    'Simta':
        'BBX2uvR45hyBjFxoBqE9lBhT+T3JlX3QjEpJoEtOhJhKqGvT4dvYuOa4XgFxBmI2QsToJ0bvE2Q9OgQ8KmLxEF8MmQyB2BoIwB3Q',
  },
  'Syangja': {
    'Aandhikhola':
        'BBRklnRi7kzBjOzOjE7Q7WgF3H3OpG4K3JAsG8dvE4M4C2T+JlLqBwI2HN+OjRvC1JiXuE8FlG',
    'Arjunchaupari':
        'BBSk5lRkyjzBvLhUxHpC1KuP/GvQ3FiQzNyL8FsFtD+C2GuWmK1CwHqIhB6HsOlD9E3iB4JA2BvJuJZ',
    'Bhirkot':
        'BBU4xkRokjzB1CnGvLqC7H5LlLiLhHdA6ZtOuZuB+FyG9DIgdoL8Q8CxcsJGcxGqO9HvGnYuD9C7FrF2QzR',
    'Biruwa':
        'BBZgokR2knzBjJ5vBtC6EtEjFvJoNpHlHtakGvHvD5DmK/H9BtD8RnRPqckN0GrQ4GqG9DqGkN8NoCrE2IiEmEhH8MkGiE5DgGqJiJlEoBtJ',
    'Chapakot':
        'BBe2qiRi4lzBqEzE3D/C1MuBwCzNtXqIiIvLpBpMsFhC/G5PgH3JpR6B1XwgB6CyI5FsPoIFhFoIoJ+LxMyd8E8KmLf5CiHoHiGgNzFyBnY9HlHqROsD5R+HgCoJnP',
    'Galyang':
        'BBhB0ljRg0hzBKzGxGvCkE7N7JvB3FxL1M+O1pB8PwByN0P8M7G0E2EgEpCuSxM8O8EoB3CqIsU1EpF8KwD4FuKA+BnayE5GyIuGyClJnLkC1E3M0OtMuDqGgB7K4MsC5D3IyKnBUnN',
    'Harinas':
        'BBX87jRuznzBzG5KzBoEnNlG5DkH7IhE/BuEpNhOiElG9GpGtGsQzUhHb4YxO0FmHgL0d/GmJ+HuPF2N6gBoJxV+HjB7FzRuIxL',
    'Kaligandaki':
        'BBS4wiRsy+yB3ercgB4MpH0O0D4N0H4BrK0JsJqE7G8KqJkOxHyB3EgR4G4LsUnH8HzKzBxZ/HzRoLvW',
    'Phedikhola': 'BBK8hnR8mlzBnE3GtVlDwC2JzW8V5C2oBgTLwOxQwCpa0M7S',
    'Putalibazar':
        'BBci3lR0nnzBqDnEjJ6BV5FsGnlB/DtKxK6KerbxOsDehIvI7IxXoNhB2GvIhBe0UgFvEuJ6C0F0Y1DuDyHiOrC4a0CyE+GnFgIyTqK6HgK5BkHzNqB1f',
    'Walling':
        'BBmB61jR84izB8FrEnOQ5IlTlKecsK7J9Df8KjDnGhEmG5D/C5GyNuEsIoLjCxCmJxItGxE6G2BwTzD4GtKAwDiKrFiChF0Z0ErGkR3DvBuP0CtF6MmFhEkN4c5FvH3bkDrKxHgDX3FuOtZA5ZiHeoFxG',
  },
  'Tanahun': {
    'Aanbu Khaireni':
        'BBX43hR23xzBtEnTzNtCgDyM7DgCvLjJ6D7H5VhPIyQ5J6HnJjE9BkThHnH1CqlBsKmEkC6UmOoC8KpLkS+C4HlEfpX0EmDuLpY',
    'Bandipur':
        'BBao4iR05vzBvOEiClKtItF7HoKhSVhMlKjE8I5JjG9FwIY+NrQgZamLgN9F2CxR4SmQ5D8HsHoG+HiBN1NkLsD0B+K+F8BoD9Y4N/DqMxa',
    'Bhanu':
        'BBWirlRsuwzBrBrkB1NDjBtJ5StK7H8E1D6P9GK/CyNjOtT7G8I9GrB7EyK6GuBlJwWpRsJyQ8C4PsWqdwF0EmH8cnV6Nza',
    'Bhimad':
        'BBXoqjR+0pzBxFldnK1QtPGlJ9HziByE4PsW/G6cqHhByIqIjMuEA8FkLoDmFgL5DkK2O+YqGtL9GnMmFhUqEnHmJ8EkKrDkH5S',
    'Byas':
        'BBlB6olR+kvzBzbt/BgM/ENhSnHtJtGkE/MzIxS2bzJlBtPwTnTjG1BsL4K6K7T8BnNuW/RqI1FiN6JkGkE7IgMmKkSW8HnKsIuFhCgKwEasI1NgHqBoGhJ4O0TgDxN+GJ2D5P8H7E6SuK2B4J4JOwCvF',
    'Devghat':
        'BBbowgRmovzBtJzT9Q5JjLoIxQvD/EgJnW0G/CqJgG+MiNuE+C2GxMsYhL4CeuJqKuInEiN4MlG2DrOsHpFmO2B0LmVsBtSwGrCqE1UkLrLX9N4GjM',
    'Ghiring':
        'BBfq7hRg3qzBvEjLlLlDC9FkMnExIvIpHiBgH5cvPnRzD5R9EpBkD1G7F5CxJ4G6BgPxNud6GuB9HuU+M6QlC4M9EnDkCuI7G4E6F0CvC+L2K2CX/OiF+Ewc1B+JyE6D9P',
    'Myagde':
        'BBPwikRw0rzB7OvIoCvL7NrF2BlInI/H1R/DvJmb+GsM1K+PpD+pBoTkGuPvTuJsBmXxnB',
    'Rishing':
        'BBbs9hR4huzBoLnEtLlLOnbsJ1gB1M/Q/fExQjGgCqPhJ1B3FxNI8VtFcgIiKAiSxIyE8EwClGuH0FuBU6H7IkRuD2RkQ2HoKwQiWlOoNtW6IkB',
    'Shuklagandaki':
        'BBbuklRg3ozBpK7H/HxTtH8E9DnSzK8E1IwM+FwRvKmGlJwVqEkM/J+Q2JkJ1BmI8NsFnCwLgQ2FnGgP2NuIuGjEkG0IqJn5BrU7UuLrb6FYEjJwGxE',
  },
  'Taplejung': {
    'Aatharai Tribeni': 'BBL2y2Qwiv1B1QrGxTvdnM5EzPokC6B4R6O4J+Z1clBxI2TlJuC7H',
    'Maiwakhola': 'BBLq33Qsgt1BkgBlXniBjFpMrH15BmhBlO+YyaiWuGoPgR0F4BzekiBhhB',
    'Meringden':
        'BBT4u6Q6lt1BiRmGyBnE9T1T7MsDjpBnOpVwSrHpBlIqP5duZDmajHsO8L2DowB9M+PgD4HtPuOpHqLlduT5L',
    'Mikwakhola':
        'BBiB4m9Q0zw1BkRpWjR3GtDjP1SnFe7Q0KnDqDtIpY5JxElIhJ8HxDrGlXpDrBlJpR7DhR4MpLmdtOqH3HuP9P/CjzB0M0GyVmNqOxB7F8LlLgTtD2Z8LyVnEyMqYmU+UoRlC4CrG2X6CmjB1Z',
    'Phaktanglung':
        'BB2B49hRowz1BzT7FY9G5NjS7U3DlT3VlQ1GxBpqBzKuHzRzMjHkE/HvInsB6sB/fW3CsGnRmClU9UxMpYxVoE1Z7L/SuD7LmL2N6QpE4lBsW+XgCqb6Z0hBoI3CuOoRsdg0BuD6a6O8Lqc6H0H+TmToXoYoG8DyMiS2BqJiKySjPyKyRoK/CqO5dsDlNpJ7T8R3H9F7LoMvWvMnbgU7gBtEtpBmLtHgM8BmC9N',
    'Phungling':
        'BBR6+3Qs7y1B2JGrW9XoE/lBnZ/Y7G9VlPxCjLmIsBqIzQuS+oBijBqBwGnK0FrDgR4VN4IkL4V+B',
    'Sidingba':
        'BBO2x3Q4z31B6L0O8BtG/NvV4LvYrHtQzcvdtM1enJjGlLkD9b7PW4sC2bkfq4BgZ',
    'Sirijangha':
        'BBqB4t8Q6y51B+M8FiH/DlTnXvH5Ttc9H5O7L1C5YlT1kBrZviBnI2C5ZzhBuCjM/FjMnSpH7M0C3IjLtmBnDrEkSxHxD9KyVmTqNwPzB0JkHiLwd0cwdsHuQ3LwYgOwV7BuG2LR8MtO+KDiKkL8IyDwFjFyS4NwEzDkIoEgQ4T8VgEiP8P',
    'Yangwarak':
        'BBP+22Q04x1BnPlWlCqFzZtY5K4K9HoW1D4e8GsfuFoB+KxVyHyDsEjS0T8BOlP6IrF',
  },
  'Terhathum': {
    'Aatharai': 'BBLo+0Qgqu1BPtJjU2X1tC+fkNgoBmXwH+M+UgKrDmdtpB5B3RwLvzB',
    'Chhathar':
        'BBO8nxQ2xs1BuCrG1P/UsLzXl3Bgc9VtB7BuPkO+d0TgTkIzF0G0CuKmQmRxe4EjW',
    'Laligurans': 'BBNk7yQ8os1BFxVnH/K1TlD9HvHhSiBrLyX2PiVlH+c2ZjIoI9N2SRoDlI',
    'Menchhyayem': 'BBLgh1Q21t1B0DlKnEzFxrBhajKibpLsNgNYuL6SgRoB+U5IkDhK',
    'Myanglung':
        'BBO8rzQ26s1B+I7OlOe1I/JlG8O1SSnI+NlaoI1QueoXoQ6GyNmPnjBoiBjNuK3Y',
    'Phedap':
        'BBPs60Qgju1BuC1D/T4J7QlBxL7SzXmBvViLnH2KlGmgBmJoO+N5EwMxKyRxB0iBlR2QxU',
  },
  'Udayapur': {
    'Belaka':
        'BBb29tQ8/l1BhLjfzB5f9MnY8CtH9M5NtP5FiC/H/WmK9F9CxCkIlSzRT9JvP0B3GkJ2BmOtQ+MoMkEnEkMsVmStHoN2F6Y6mB8XghBuGkMgK6JZ8O1O',
    'Chaudandigadhi':
        'BBeuvtQ+9h1BzFzMNzgB5M7VrNkH5VaoLzJlQzM8GzJdxLnONlL2HjDqPtV+C7Q9FhBkVjMmDJ8EieknBuMpB8QqjBmI8DkClI+F+C+WlK/BgIuP6FuN4OiJpJjBza',
    'Katari':
        'BBuBs5yQ6v30BJxJlWrKmExP3WvKpBrMjGuK0EqLpEsN9UpKvH4KpKqC5D4JvpBhSflY9I1T1W9PzFjVxJ3B8Z9nB5HLvhBm4BoOuZ5IixBgXwLnNo7BgK1BkC4JsP5NqOkN0dnbwEkE7DgF0HoEsStDeiOqZtJ6BiJoJuDInTmR9IShM0IgH2B3K2J9B6G1K',
    'Rautamai':
        'BBY6ywQk290BjO3W/H8ChB5NqL3IwCxMP3J9M7N/NjEjF+HxPoF3f3BlG8HjDnEpDoEzKrCsS0XtBoF0KkF4KqsBxDoQk1B9JuJ5MgP3F',
    'Sunkoshi':
        'BBQ0pyQok70B5BrI3ZoFlOyLvW3BhG0F2F6EhCqW9JmFF0R8HjDqB6HsOoL4RnIqVxc4NvoB',
    'Tapli':
        'BBPmmyQ0860B5GtZ1LnJnHpRlJrD7BjJrZsJxOuiB4G6P5HwO8I2J0N/FgR4CmOxLkYjE',
    'Triyuga':
        'BBmBwouQ2j+0B7KhuBrKtEuBnF3c3hBBjL1MkBpJ9JnbrIvCoR5XvPjEgN3KjBpQiJoCyJ3GwF4FsTpF8EmJ0JnKuM+LuNoDkTpQkKyQme+QgGsV7CmDrPmL1H+NMoB0L7G0JmQ0MnL0J6VZsNjH2GziByhBhFuDlP',
    'Udayapurgadhi':
        'BBgBuowQ4j50BpBnMrSuDpH5DyDtFrF/D3ckbpOjNrP6NnC5JxUmCrR0XpHmBR8V7JV5OzO3FqLmf2JqJ+J2MjBCkLkP4LmJvDuDkEyF3HigB4ByPnFiF7HoMSgG7NzG7O6OpjB',
  },
};

/// Boundaries that could not be joined to a canonical roster entry.
const Map<String, String> kUnmatchedPalikaBoundaries = {};
