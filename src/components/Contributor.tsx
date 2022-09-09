import React from 'react'
import Router from 'next/router'

export type ContributorProps = {
  login: string
  count: number
  since: date
}

const Contributor: React.FC<{ contributor: ContributorProps }> = ({
  contributor,
}) => {
  return (
    <tr
      onClick={() =>
        Router.push('/contributor/[login]', `/contributor/${contributor.login}`)
      }
    >
      <td>-</td>
      <td>{contributor.login}</td>
      <td>{contributor.count}</td>
      <td>{contributor.since}</td>
    </tr>
  )
}

export default Contributor
