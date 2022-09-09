import { useRouter } from 'next/router'

import { Meta } from '@/layouts/Meta'
import { Main } from '@/templates/Main'
import type { GetServerSideProps } from 'next'
import { Contributor, ContributorProps } from '@/components/Contributor'
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

export const getServerSideProps: GetServerSideProps = async () => {
  const contributors = await prisma.contributor.findMany({
    select: { login: true, commitsCount: true, since: true },
    orderBy: [
      {
        commitsCount: 'desc',
      },
      {
        since: 'asc',
      },
    ],
  })
  return {
    props: { contributors },
  }
}

type Props = {
  contributors: ContributorProps[]
}

const Index = (props) => {
  const router = useRouter()

  return (
    <Main
      meta={
        <Meta
          title='Hanami Contributors'
          description='Open Source contributors to the Hanami Ruby project'
        />
      }
    >
      <table className='table-auto'>
        <thead>
          <tr>
            <th>Rank</th>
            <th>GitHub Login</th>
            <th>Contributions</th>
            <th>Since</th>
          </tr>
        </thead>
        <tbody>
          {props.contributors.map((contributor, index) => (
            <tr key='{contributor.login}'>
              <td>{index + 1}</td>
              <td>{contributor.login}</td>
              <td>{contributor.commitsCount}</td>
              <td>{contributor.since}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </Main>
  )
}

export default Index
