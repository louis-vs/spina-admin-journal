# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'MyJournal', theme: 'default'
  User.first_or_create name: 'Marcus Atherton', email: 'someone@someaddress.com', password: 'password', admin: true

  module Admin
    module Journal
      journal = Journal.first_or_create name: 'The Best Journal'
      vol1, vol2 = Volume.create! [{ journal: journal, number: 1 },
                                   { journal: journal, number: 2 }]
      vol1_issue1, vol1_issue2 = Issue.create! [{ volume: vol1, number: 1, date: '2020-12-25' },
                                                { volume: vol1, number: 2, date: '2020-12-25' }]
      vol2_issue1, vol2_issue2 = Issue.create! [{ volume: vol2, number: 1, date: '2020-12-25' },
                                                { volume: vol2, number: 2, date: '2020-12-25' }]
      vol1_issue1_article1, vol1_issue1_article2 = Article.create! [{ issue: vol1_issue1, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol1_issue1, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol1_issue2_article1, vol1_issue2_article2 = Article.create! [{ issue: vol1_issue2, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol1_issue2, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol2_issue1_article1, vol2_issue1_article2 = Article.create! [{ issue: vol2_issue1, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol2_issue1, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol2_issue2_article1, vol2_issue2_article2 = Article.create! [{ issue: vol2_issue2, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol2_issue2, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      institution_country_house, institution_jordan_college = Institution.create! [{ name: 'Country House' },
                                                                                   { name: 'Jordan College, Oxford' }]

      affiliation_attrs_ernold = [{ institution: institution_jordan_college, first_name: 'Dan', surname: 'Abnormal', status: 'primary' }] # rubocop:disable Layout/LineLength
      affiliation_attrs_dan = [{ institution: institution_country_house, first_name: 'Ernold', surname: 'Same', status: 'primary' }] # rubocop:disable Layout/LineLength
      author_ernold, author_dan = Author.create! [{ affiliations_attributes: affiliation_attrs_ernold },
                                                  { affiliations_attributes: affiliation_attrs_dan }]

      Authorship.create! [{ article: vol1_issue1_article1, affiliation: author_ernold.primary_affiliation },
                          { article: vol1_issue1_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue1_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue2_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue2_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue1_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue1_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue2_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue2_article2, affiliation: author_dan.primary_affiliation }]
    end
  end
end
