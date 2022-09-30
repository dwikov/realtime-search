import React, { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import Form from 'react-bootstrap/Form';
import BarChart from './BarChart';
import ResultsTable from './Table';
import { Container } from 'react-bootstrap';
import { getAnalytics, matchAll, postAnalytics } from '../api';

const Search = () => {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState([]);
  const [analytics, setAnalytics] = useState([]);

  React.useEffect(() => {
    getAnalytics().then(data => setAnalytics(data));
  }, [])

  React.useEffect(() => {
    const delayDebounceFn = setTimeout(() => {
      if(query.length === 0) return;
      postAnalytics(query)
        .then(data => setAnalytics(data))
        .catch(e => console.log(e));
    }, 2000);

    return () => clearTimeout(delayDebounceFn)
  },[query]);

  const handleControlChange = React.useCallback((e) => {
    if(e.target.value.length >= 1){
      matchAll(e.target.value).then(data => setResults(data));
    }
    else{
      setResults([]);
    }
    
    setQuery(e.target.value);
  });


  return (<>
      <Container className='mt-5'>
        <Form>
          <Form.Control type="search" placeholder="Search here" value={query} onChange={handleControlChange}/>
        </Form>
        <Container className='overflow-auto' style={{ height: '350px'}}>
          <ResultsTable results={results} />
        </Container>
      </Container>
      <BarChart analytics={analytics} />
    </>
  );
};

export default Search;
