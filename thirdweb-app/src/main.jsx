import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter as Router } from 'react-router-dom';
import { ThirdwebProvider } from '@thirdweb-dev/react';
import { Sepolia } from '@thirdweb-dev/chains';
import { StateContextProvider } from './context';
import App from './App';
import './index.css';

const root = ReactDOM.createRoot(document.getElementById('root'));

// Access the client ID from the environment variable
const clientId = import.meta.env.VITE_CLIENT_ID;
console.log("Thirdweb Client ID:", import.meta.env.VITE_CLIENT_ID);

root.render(
  <ThirdwebProvider activeChain={Sepolia} clientId={clientId}>
    <Router>
      <StateContextProvider>
        <App />
      </StateContextProvider>
    </Router>
  </ThirdwebProvider>
);
