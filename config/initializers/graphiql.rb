GraphiQL::Rails.config.initial_query = '
  {
    events(first:5, scope: "upcoming") {
      edges {
        node {
          name_or_bands
          beginning_at
          poster
          
          user {
            username
          }
          
          venue {
            name address
          }
          
          bands(first:5) {
            edges {
              node {
                name
                country_code
                photo
              }
            }
          }
        }
      }
      
      pageInfo {
        hasNextPage
        hasPreviousPage
        endCursor
        startCursor
      }
    }
  }
'
