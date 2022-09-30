import React, { useState } from 'react';

import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';
import { Bar } from 'react-chartjs-2';

ChartJS.register(
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
  Legend
);

export const options = {
  responsive: false,
  plugins: {
    legend: {
      display: false,
    },
    title: {
      display: true,
      text: 'Search activity analysis',
    },
  },
};

const BarChart = ({ analytics }) => {
  analytics.sort( (a, b) => b.count - a.count );
  const labels = analytics.map((item) => item._id);
  const count = analytics.map((item) => item.count);
  const data = {
    labels,
    datasets: [
      {
        data: count,
        backgroundColor: 'rgba(86, 147, 245)',
       
      },
    ],
  };

  return <Bar options={options} data={data} width={600} height={400} style={{position: 'absolute', top: '50%', left: '30%'}}/>;
};

export default BarChart;