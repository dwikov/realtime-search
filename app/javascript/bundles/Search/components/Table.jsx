import { Table } from "react-bootstrap";
import React from 'react';

const ResultsTable = ({results}) => {
  return <Table>
    <thead>
    <tr>
      <th>#</th>
      <th>Title</th>
      <th>Body</th>
    </tr>
    </thead>
    <tbody>
    {results.map((result, index) => (
      <tr key={index}>
        <td> {index+1} </td>
        <td> {result.title} </td>
        <td> {result.body} </td>
      </tr>
    )) } 
    </tbody>
  </Table>;
}

export default ResultsTable;