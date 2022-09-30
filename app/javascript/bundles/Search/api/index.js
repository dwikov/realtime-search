

export const getAnalytics = () => fetch('/activities', {
  method: 'GET',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
  }
}).then(response => response.json());

export const postAnalytics = (query) => fetch('/activities', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
  },
  body: JSON.stringify({ activity: { query } })
}).then(response => response.json());


export const matchAll = (value) => fetch('/match_all', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
  },
  body: JSON.stringify({ query: value })
}).then(response => response.json())