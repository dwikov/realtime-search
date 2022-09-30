import ReactOnRails from 'react-on-rails';

import Search from '../bundles/Search/components/SearchServer';

// This is how react_on_rails can see the HelloWorld in the browser.
ReactOnRails.register({
  Search,
});
