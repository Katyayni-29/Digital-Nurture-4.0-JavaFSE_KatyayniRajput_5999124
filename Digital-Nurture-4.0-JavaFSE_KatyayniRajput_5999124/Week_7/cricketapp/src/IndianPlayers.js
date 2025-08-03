import React from 'react';

const T20Players = ['First Player', 'Second Player', 'Third Player'];
const RanjiTrophyPlayers = ['Fourth Player', 'Fifth Player', 'Sixth Player'];

export const IndianPlayers = [...T20Players, ...RanjiTrophyPlayers];

export const OddPlayers = ({ players }) => {
  const [first, , third, , fifth] = players;
  return (
    <div>
      <h1>Odd Players</h1>
      <ul>
        <li>First : {first}</li>
        <li>Third : {third}</li>
        <li>Fifth : {fifth}</li>
      </ul>
    </div>
  );
};

export const EvenPlayers = ({ players }) => {
  const [, second, , fourth, , sixth] = players;
  return (
    <div>
      <h1>Even Players</h1>
      <ul>
        <li>Second : {second}</li>
        <li>Fourth : {fourth}</li>
        <li>Sixth : {sixth}</li>
      </ul>
    </div>
  );
};

export const MergedPlayersList = ({ players }) => {
  return (
    <div>
      <h1>List of Indian Players Merged:</h1>
      <ul>
        {players.map((player, index) => (
          <li key={index}>Mr. {player}</li>
        ))}
      </ul>
    </div>
  );
};