using CatalogService from './cat-service';

annotate CatalogService.Authors with {
  name 
    @Common.Label : 'Author';
};

annotate CatalogService.Books with {
  ID 
    @Common.Label : 'Id';
  title 
    @Common.Label : 'Title';
  stock 
    @Common.Label : 'Stock';
  author
    @Common.Text: "author/name"
    @Common.Label : 'Author'
    @sap.value.list: 'fixed-values'
    @Common.ValueList: { 
      CollectionPath: 'Authors',
      Label: 'Authors',
      SearchSupported: 'true',
      Parameters: [
        { $Type: 'Common.ValueListParameterOut', LocalDataProperty: 'author_ID', ValueListProperty: 'ID'},
        { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name'},
      ]
    };
    
};

annotate CatalogService.Books with @(
  UI.LineItem: [ 
    {$Type: 'UI.DataField', Value: ID},
    {$Type: 'UI.DataField', Value: title},
    {$Type: 'UI.DataField', Value: stock},
    {$Type: 'UI.DataField', Value: "author/name"},
  ],
  
  UI.HeaderInfo: {
    Title: { Value: title },
    TypeName:'Book', 
        TypeNamePlural:'Books'
  },
  
  UI.Identification:
  [
    {$Type: 'UI.DataField', Value: ID},
    {$Type: 'UI.DataField', Value: title},
    {$Type: 'UI.DataField', Value: "author/name"}
  ],
  
  UI.Facets:
  [
    {
      $Type:'UI.CollectionFacet', 
      Facets: [
            { $Type:'UI.ReferenceFacet', Label: 'General Info', Target: '@UI.Identification' }
          ],
      Label:'Book Details',		
    },
    {$Type:'UI.ReferenceFacet', Label: 'Orders', Target: 'orders/@UI.LineItem'},
  ]	
);

annotate CatalogService.Orders with {
  ID 
    @Common.Label: 'Order'
    @Common.FieldControl: #ReadOnly;
  book 
    @Common.Label: 'Book'
    @Common.FieldControl: #ReadOnly;
  buyer  
    @Common.Label: 'Buyer'
    @Common.FieldControl: #ReadOnly;
  date    
    @Common.Label: 'Date'
    @Common.FieldControl: #ReadOnly;
  amount 
    @Common.Label: 'Amount'
    @Common.FieldControl: #ReadOnly;
};

annotate CatalogService.Orders with @(
  UI.LineItem: [ 
    {$Type: 'UI.DataField', Value: ID},
    {$Type: 'UI.DataField', Value: book},
    {$Type: 'UI.DataField', Value: buyer},
    {$Type: 'UI.DataField', Value: date},
    {$Type: 'UI.DataField', Value: amount}
  ],

  UI.HeaderInfo: {
    Title: { Value: ID },
    TypeName:'Order', 
        TypeNamePlural:'Orders'
  },

  UI.Identification:
  [
      {$Type: 'UI.DataField', Value: ID},
      {$Type: 'UI.DataField', Value: book},
      {$Type: 'UI.DataField', Value: buyer},
      {$Type: 'UI.DataField', Value: date},
      {$Type: 'UI.DataField', Value: amount}

  ],
  UI.Facets:
  [
    {
      $Type:'UI.CollectionFacet', 
      Facets: [
            { $Type:'UI.ReferenceFacet', Label: 'Assignment', Target: '@UI.Identification' }
          ],
      Label:'Orders',		
    }
  ]	
);