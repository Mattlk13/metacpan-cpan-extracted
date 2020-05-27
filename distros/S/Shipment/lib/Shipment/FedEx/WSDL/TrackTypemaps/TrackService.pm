
package Shipment::FedEx::WSDL::TrackTypemaps::TrackService;
$Shipment::FedEx::WSDL::TrackTypemaps::TrackService::VERSION = '3.05';
use strict;
use warnings;

our $typemap_1 = {
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/PagerNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/WebAuthenticationDetail/UserCredential/Password'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ReturnDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackReturnDetail',
    'TrackRequest/TransactionDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Service' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackServiceDescriptionDetail',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/TrackingNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/TransactionDetail/CustomerTransactionId'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CustomsValue/Amount'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails/Type'
      => 'Shipment::FedEx::WSDL::TrackTypes::AppointmentWindowType',
    'SendNotificationsReply/TransactionDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/Title' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/HighestSeverity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/PagingToken' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/TransactionDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/NetCostMethod'
      => 'Shipment::FedEx::WSDL::TrackTypes::NaftaNetCostMethodCode',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/MultiPiece' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/ClearanceLocationCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/StreetLines' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Reconciliation' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackReconciliation',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/PhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/PersonName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Weight' =>
      'Shipment::FedEx::WSDL::TrackTypes::Weight',
    'TrackReply/CompletedTrackDetails/TrackDetails/FormId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/PreferenceCriterion'
      => 'Shipment::FedEx::WSDL::TrackTypes::NaftaPreferenceCriterionCode',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/RecipientDetails/NotificationEventsAvailable'
      => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationEventType',
    'TrackRequest/ClientDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Weight/Units'
      => 'Shipment::FedEx::WSDL::TrackTypes::WeightUnits',
    'TrackReply/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Service/ShortDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SendNotificationsReply/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'SendNotificationsReply/Notifications/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'Fault/faultcode' => 'SOAP::WSDL::XSD::Typelib::Builtin::anyURI',
    'SendNotificationsRequest/TransactionDetail/CustomerTransactionId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Carrier' =>
      'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Barcode/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/HighestSeverity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensions/Height'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/PostalCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail/Status'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackAdvanceNotificationStatusType',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/AncillaryDetails/ActionDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/CompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities' =>
      'Shipment::FedEx::WSDL::TrackTypes::Commodity',
    'SendNotificationsReply/Notifications/MessageParameters/Id' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialHandlings/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/NetCostDateRange/Begins'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'SendNotificationsRequest/SenderEMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/DuplicateWaybill' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SendNotificationsRequest/ClientDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/ProducerDetermination'
      => 'Shipment::FedEx::WSDL::TrackTypes::NaftaProducerDeterminationCode',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/CountryCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/HighestSeverity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/MessageParameters/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/TransactionDetail/CustomerTransactionId'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryOptionEligibilityDetails/Eligibility'
      => 'Shipment::FedEx::WSDL::TrackTypes::EligibilityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers/PackageIdentifier/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest' =>
      'Shipment::FedEx::WSDL::TrackElements::SendNotificationsRequest',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/Title' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/TrackingNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ReturnDetail/LabelType' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackReturnLabelType',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/Title' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CommitmentTimestamp' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'SignatureProofOfDeliveryLetterRequest' =>
      'Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryLetterRequest',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/StreetLines' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Service/Type' =>
      'Shipment::FedEx::WSDL::TrackTypes::ServiceType',
    'TrackRequest/ClientDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackagingType' =>
      'Shipment::FedEx::WSDL::TrackTypes::PackagingType',
    'TrackRequest/SelectionDetails/ShipmentAccountNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/MessageParameters'
      => 'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SendNotificationsReply/Packages/TrackingNumberUniqueIdentifiers' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'SignatureProofOfDeliveryLetterRequest/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PieceCountVerificationDetails/Count'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/NetCostDateRange'
      => 'Shipment::FedEx::WSDL::TrackTypes::DateRange',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NumberOfPieces'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination/CountryCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/AccountNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/TransactionDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/ShipDateRangeEnd' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackRequest/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Name' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentContents/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Reconciliation/Status' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/ClientDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/PhoneNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/UnitPrice/Amount'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'Fault/faultactor' => 'SOAP::WSDL::XSD::Typelib::Builtin::token',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/CompanyName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Packaging' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/QuantityUnits'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryLocationDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/FaxNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DistanceToDestination/Units'
      => 'Shipment::FedEx::WSDL::TrackTypes::DistanceUnits',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/ExciseConditions/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/StatusDetail'
      => 'Shipment::FedEx::WSDL::TrackTypes::SpecialInstructionStatusDetail',
    'TrackReply/TransactionDetail/CustomerTransactionId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/StatusExceptionDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/ReturnDetail/AuthorizationName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/TransactionDetail/CustomerTransactionId'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Notifications/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/TotalTransitDistance/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/PagingDetail/PagingToken' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Notifications/MessageParameters/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients/EMailNotificationRecipientType'
      => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationRecipientType',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'TrackReply/CompletedTrackDetails/TrackDetails/Charges' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackChargeDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/FaxNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination'
      => 'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/SplitShipmentParts/PieceCount'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::positiveInteger',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/WebAuthenticationDetail/UserCredential'
      => 'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/FaxNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/NickName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'SignatureProofOfDeliveryFaxReply/Notifications/MessageParameters' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/PagerNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryLocationType' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackDeliveryLocationType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/ExciseConditions/Category'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PieceCountVerificationDetails/CountLocationType'
      => 'Shipment::FedEx::WSDL::TrackTypes::PieceCountLocationType',
    'TrackReply/CompletedTrackDetails/TrackDetails/CartageAgentCompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee' =>
      'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
    'SignatureProofOfDeliveryFaxRequest' =>
      'Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxRequest',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'SendNotificationsReply/DuplicateWaybill' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackSpecialInstruction',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensionalWeight/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/AdditionalMeasures/Quantity'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'SignatureProofOfDeliveryLetterReply/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/TrackingNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomsOptionDetails/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/PhoneExtension'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/TrackingNumberUniqueIdentifier' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination/CountryName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/AncillaryDetails/Action'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Notifications/LocalizedMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CIMarksAndNumbers'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail/EstimatedTimeOfArrival'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'SignatureProofOfDeliveryLetterRequest/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'SignatureProofOfDeliveryLetterReply/Notifications/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Weight/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/CompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/PhoneExtension' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest' => 'Shipment::FedEx::WSDL::TrackElements::TrackRequest',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/TransactionDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients/NotificationEventsRequested'
      => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationEventType',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/ShipDate'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/ExportLicenseNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/PagingDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::PagingDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensions/Units' =>
      'Shipment::FedEx::WSDL::TrackTypes::LinearUnits',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/Title'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail/StatusTime'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CustomsValue/Currency'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient' =>
      'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackAdvanceNotificationDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/PagingToken' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'TrackRequest/SelectionDetails/PackageIdentifier/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail/Reason'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply' =>
      'Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryFaxReply',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/FaxNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/CreationTime'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'SendNotificationsReply/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/OriginalRequestTime'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/HighestSeverity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/TransactionDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'SendNotificationsReply/Notifications/MessageParameters' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SignatureProofOfDeliveryFaxReply/Notifications/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails/Window/Ends'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/TotalTransitDistance' =>
      'Shipment::FedEx::WSDL::TrackTypes::Distance',
    'TrackReply/CompletedTrackDetails/Notifications/MessageParameters/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/Message'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'TrackReply/CompletedTrackDetails/TrackDetails/SplitShipmentParts/StatusDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress'
      => 'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/AdvanceNotificationDetail/StatusDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/PackageIdentifier/Type' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackIdentifierType',
    'SignatureProofOfDeliveryFaxReply/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ReturnDetail/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginStationId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationServiceAreaDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Service/Description' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/PhoneExtension'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/TotalUniqueAddressCountInConsolidation'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/StatusDetail/Status'
      => 'Shipment::FedEx::WSDL::TrackTypes::SpecialInstructionsStatusCode',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipTimestamp' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationStationId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination/CountryCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/WebAuthenticationDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentWeight/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/Code'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackRequest/ClientDetail/MeterNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialHandlings' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackSpecialHandling',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Image' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress'
      => 'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/PhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetailsCount' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/AncillaryDetails/ReasonDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Charges/Type' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackChargeDetailType',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers/PackageIdentifier'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier',
    'SendNotificationsRequest/ClientDetail/AccountNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/Source'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Charges/ChargeAmount/Amount'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomerExceptionRequests/CreateTime'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AppointmentDeliveryTimestamp'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/IntegratorId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/TransactionDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageCount' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageWeight' =>
      'Shipment::FedEx::WSDL::TrackTypes::Weight',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers/CarrierCode'
      => 'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'TrackReply/CompletedTrackDetails/TrackDetails/CarrierCode' =>
      'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'TrackReply/CompletedTrackDetails/Notifications/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notes' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/MessageParameters/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/ProducerId'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/TotalTransitDistance/Units'
      => 'Shipment::FedEx::WSDL::TrackTypes::DistanceUnits',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Notifications/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationDetail',
    'Fault/faultstring' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/WebAuthenticationDetail/UserCredential/Password'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination/Residential' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/PieceCountVerificationDetails'
      => 'Shipment::FedEx::WSDL::TrackTypes::PieceCountVerificationDetail',
    'SendNotificationsReply' =>
      'Shipment::FedEx::WSDL::TrackElements::SendNotificationsReply',
    'Fault' => 'SOAP::WSDL::SOAP::Typelib::Fault11',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageWeight/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/LocalizedMessage'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/MessageParameters/Id' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationType' =>
      'Shipment::FedEx::WSDL::TrackTypes::FedExLocationType',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber' =>
      'Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'SignatureProofOfDeliveryFaxRequest/AdditionalComments' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Notifications/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/AdditionalMeasures/Units'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/CompanyName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Notifications/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'SignatureProofOfDeliveryLetterReply/Letter' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::base64Binary',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/OriginalEstimatedDeliveryTimestamp'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/PostalCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Reconciliation/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail/NetCostDateRange/Ends'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/CountryName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Quantity' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'SendNotificationsRequest/ClientDetail/MeterNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/Notifications/MessageParameters/Id' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination/CountryName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/PersonName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OperatingCompany' =>
      'Shipment::FedEx::WSDL::TrackTypes::OperatingCompanyType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/ExportLicenseExpirationDate'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'SignatureProofOfDeliveryLetterReply/Notifications/MessageParameters' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SignatureProofOfDeliveryFaxRequest/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SignatureProofOfDeliveryFaxReply/Notifications/MessageParameters/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/PhoneNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/CompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackStatusDetail',
    'SignatureProofOfDeliveryFaxReply/Notifications/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OfficeOrderDeliveryMethod'
      => 'Shipment::FedEx::WSDL::TrackTypes::OfficeOrderDeliveryMethodType',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/Date'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/Version/Minor' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/CountryCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensions' =>
      'Shipment::FedEx::WSDL::TrackTypes::Dimensions',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageWeight/Units' =>
      'Shipment::FedEx::WSDL::TrackTypes::WeightUnits',
    'SignatureProofOfDeliveryLetterReply/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'Fault/detail' => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/TransactionTimeOutValueInMilliseconds' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/PieceCountVerificationDetails/Description'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/WebAuthenticationDetail/UserCredential/Password' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/TransactionDetail/CustomerTransactionId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageContents' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/MoreDataAvailable' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackRequest/SelectionDetails/PackageIdentifier' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackPackageIdentifier',
    'SignatureProofOfDeliveryFaxReply/Notifications/LocalizedMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CommodityId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/PagerNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/TrackingNumberUniqueIdentifier'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination/Residential' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/DistanceToDestination' =>
      'Shipment::FedEx::WSDL::TrackTypes::Distance',
    'TrackReply/CompletedTrackDetails/TrackDetails/EstimatedPickupTimestamp'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackRequest/TransactionDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination/PostalCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/SenderContactName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/Title'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress'
      => 'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
    'SignatureProofOfDeliveryFaxReply/Notifications/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OperatingCompanyOrCarrierDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/ClientDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/PhoneNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentContents/ItemNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/NotificationEventsAvailable'
      => 'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationEventType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/Severity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Barcode/Type' =>
      'Shipment::FedEx::WSDL::TrackTypes::StringBarcodeType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/Description' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/CompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/FaxNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/LetterFormat' =>
      'Shipment::FedEx::WSDL::TrackTypes::SignatureProofOfDeliveryImageType',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/IntegratorId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensions/Width' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Notifications/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryTimestamp' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails/Window'
      => 'Shipment::FedEx::WSDL::TrackTypes::LocalTimeRange',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/PhoneNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Carrier' =>
      'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'SignatureProofOfDeliveryLetterRequest/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/PhoneNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/PagerNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PossessionStatus' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackPossessionStatusType',
    'TrackRequest/Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'TrackReply/Notifications/MessageParameters' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/ExciseConditions'
      => 'Shipment::FedEx::WSDL::TrackTypes::EdtExciseCondition',
    'SendNotificationsReply/PagingToken' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/FaxConfirmationNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomsOptionDetails' =>
      'Shipment::FedEx::WSDL::TrackTypes::CustomsOptionDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails'
      => 'Shipment::FedEx::WSDL::TrackTypes::AppointmentTimeDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/Shipper/Title' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'SignatureProofOfDeliveryLetterReply' =>
      'Shipment::FedEx::WSDL::TrackElements::SignatureProofOfDeliveryLetterReply',
    'SendNotificationsRequest/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/CustomerSpecifiedTimeOutValueInMilliseconds'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentWeight' =>
      'Shipment::FedEx::WSDL::TrackTypes::Weight',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/TransactionDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentContents/ReceivedQuantity'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SendNotificationsRequest/NotificationDetail/Recipients/Format' =>
      'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationFormatType',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomerExceptionRequests/StatusCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/PersonName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'SignatureProofOfDeliveryFaxRequest/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'SignatureProofOfDeliveryLetterRequest/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensionalWeight/Units'
      => 'Shipment::FedEx::WSDL::TrackTypes::WeightUnits',
    'SignatureProofOfDeliveryLetterReply/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/PhoneExtension'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'TrackRequest/SelectionDetails' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackSelectionDetail',
    'SignatureProofOfDeliveryLetterReply/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SplitShipmentParts/Timestamp'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/PhoneExtension'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/Title' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime'
      => 'Shipment::FedEx::WSDL::TrackTypes::AppointmentDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact'
      => 'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'TrackReply/CompletedTrackDetails/TrackDetails/Barcode' =>
      'Shipment::FedEx::WSDL::TrackTypes::StringBarcode',
    'SignatureProofOfDeliveryFaxReply/HighestSeverity' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'SendNotificationsReply/Notifications/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxReply/TransactionDetail/CustomerTransactionId'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/Residential' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentContents/PartNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomerExceptionRequests'
      => 'Shipment::FedEx::WSDL::TrackTypes::CustomerExceptionRequestDetail',
    'TrackRequest/SelectionDetails/CarrierCode' =>
      'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/PersonName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/WebAuthenticationDetail/UserCredential'
      => 'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliverySignatureName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber' =>
      'Shipment::FedEx::WSDL::TrackTypes::QualifiedTrackingNumber',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/PostalCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/RequestedAppointmentTime/WindowDetails/Window/Begins'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications/LocalizedMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/WebAuthenticationDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
    'SendNotificationsRequest/ClientDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'SignatureProofOfDeliveryFaxReply/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/PagerNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature' =>
      'Shipment::FedEx::WSDL::TrackTypes::SignatureImageDetail',
    'SendNotificationsRequest/Version/Major' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackRequest/SelectionDetails/Destination/StreetLines' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/MeterNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/LocalizedMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender' =>
      'Shipment::FedEx::WSDL::TrackTypes::ContactAndAddress',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomsOptionDetails/Type'
      => 'Shipment::FedEx::WSDL::TrackTypes::CustomsOptionType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/PhoneExtension'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialHandlings/Type' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackSpecialHandlingType',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/EMailAddress'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications/MessageParameters' =>
      'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SignatureProofOfDeliveryLetterRequest/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SendNotificationsReply/Packages/Destination/StateOrProvinceCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/MessageParameters'
      => 'Shipment::FedEx::WSDL::TrackTypes::NotificationParameter',
    'SendNotificationsRequest/TransactionDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/AncillaryDetails/Reason'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/Residential' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SendNotificationsRequest/NotificationDetail/Recipients/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers/TrackingNumberUniqueIdentifier'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/CountryName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Charges/ChargeAmount/Currency'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/StreetLines' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/WebAuthenticationDetail/UserCredential' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/PagerNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/MoreData' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/CountryCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/TransactionDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/TransactionDetail/Localization/LocaleCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/StationId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ActualDeliveryAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentWeight/Units' =>
      'Shipment::FedEx::WSDL::TrackTypes::WeightUnits',
    'SendNotificationsReply/Packages/CarrierCode' =>
      'Shipment::FedEx::WSDL::TrackTypes::CarrierCodeType',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SendNotificationsReply/Packages/RecipientDetails' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackNotificationRecipientDetail',
    'SignatureProofOfDeliveryLetterReply/Notifications/MessageParameters/Id'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/ProcessingOptions' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackRequestProcessingOptionType',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryOptionEligibilityDetails/Option'
      => 'Shipment::FedEx::WSDL::TrackTypes::DeliveryOptionType',
    'SendNotificationsReply/Packages/Destination/UrbanizationCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackRequest/SelectionDetails/ShipDateRangeEnd' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'SignatureProofOfDeliveryLetterReply/Notifications/LocalizedMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/PersonName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/NaftaDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::NaftaCommodityDetail',
    'TrackReply/TransactionDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::TransactionDetail',
    'TrackReply/CompletedTrackDetails/Notifications/MessageParameters/Id' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SplitShipmentParts/StatusCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/CountryName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/MessageParameters/Id'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/WebAuthenticationDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/LocalizedMessage'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/PersonName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackEvent',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address' =>
      'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialHandlings/PaymentType'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackPaymentType',
    'TrackReply/Version' => 'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::ClientDetail',
    'TrackRequest/ClientDetail/IntegratorId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/Version/Major' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Contact/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/MessageParameters/Value' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomerExceptionRequests/Id'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients' =>
      'Shipment::FedEx::WSDL::TrackTypes::EMailNotificationRecipient',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/StatusDetail/StatusCreateTime'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Contact/EMailAddress'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/SpecialInstructions/DeliveryOption'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackDeliveryOptionType',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/PhoneExtension' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryAttempts' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/WebAuthenticationDetail' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationDetail',
    'TrackRequest/SelectionDetails/ShipDateRangeBegin' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/AdditionalComments' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/ArrivalLocation' =>
      'Shipment::FedEx::WSDL::TrackTypes::ArrivalLocationType',
    'SignatureProofOfDeliveryLetterRequest/WebAuthenticationDetail/UserCredential/Key'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/Residential' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/ShipDate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/CompletedTrackDetails/TrackDetails/DistanceToDestination/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::decimal',
    'SendNotificationsRequest/TrackingNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/EstimatedDeliveryTimestamp'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackRequest/SelectionDetails/Destination/UrbanizationCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination/StateOrProvinceCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationLocationTimeZoneOffset'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/PartNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Version/Major' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SendNotificationsRequest/TransactionDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/Recipients/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'SendNotificationsReply/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CountryOfManufacture'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/CustomerExceptionRequests/StatusDescription'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/WebAuthenticationDetail/UserCredential/Key' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/FaxNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Timestamp' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::dateTime',
    'TrackRequest/Version/Minor' => 'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination'
      => 'Shipment::FedEx::WSDL::TrackTypes::Address',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/EMailAddress' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackNotificationPackage',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensions/Length'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'SignatureProofOfDeliveryFaxReply/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'TrackReply/TransactionDetail/Localization/LanguageCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/AvailableImages' =>
      'Shipment::FedEx::WSDL::TrackTypes::AvailableImageType',
    'TrackReply/CompletedTrackDetails/TrackDetails/SplitShipmentParts' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackSplitShipmentPart',
    'TrackReply/CompletedTrackDetails/TrackDetails/Charges/ChargeAmount' =>
      'Shipment::FedEx::WSDL::TrackTypes::Money',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipmentContents' =>
      'Shipment::FedEx::WSDL::TrackTypes::ContentRecord',
    'SendNotificationsReply/Packages/Destination/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/FaxNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Notifications/MessageParameters/Value'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/LastUpdatedDestinationAddress/CountryName'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply' => 'Shipment::FedEx::WSDL::TrackElements::TrackReply',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address'
      => 'Shipment::FedEx::WSDL::TrackTypes::Address',
    'SendNotificationsRequest/TrackingNumberUniqueId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Attributes' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackDetailAttributeType',
    'TrackReply/CompletedTrackDetails/TrackDetails/ProductionLocationContactAndAddress/Address/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/AncillaryDetails'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackStatusAncillaryDetail',
    'SignatureProofOfDeliveryFaxRequest/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/ReturnDetail/MovementStatus'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackReturnMovementStatusType',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/Destination/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DestinationServiceArea' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/ShipDate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationAddress/Residential'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::boolean',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/EventType' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/ClientDetail/IntegratorId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/ClientDetail/AccountNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/WebAuthenticationDetail/UserCredential' =>
      'Shipment::FedEx::WSDL::TrackTypes::WebAuthenticationCredential',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageSequenceNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'SendNotificationsReply/TransactionDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/UnitPrice/Currency'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/Notifications/Source' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/Destination/CountryCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Address/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/StatusExceptionCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/PagingDetail/NumberOfResultsPerPage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::nonNegativeInteger',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackOtherIdentifierDetail',
    'TrackRequest/SelectionDetails/OperatingCompany' =>
      'Shipment::FedEx::WSDL::TrackTypes::OperatingCompanyType',
    'TrackReply/CompletedTrackDetails/TrackDetails/OtherIdentifiers/PackageIdentifier/Type'
      => 'Shipment::FedEx::WSDL::TrackTypes::TrackIdentifierType',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/CustomsValue'
      => 'Shipment::FedEx::WSDL::TrackTypes::Money',
    'SignatureProofOfDeliveryLetterRequest/ClientDetail/MeterNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/HoldAtLocationContact/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Notification/MessageParameters/Id'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/TrackingNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/StatusDetail/Location/StreetLines'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/WebAuthenticationDetail/UserCredential/Key'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/WebAuthenticationDetail/UserCredential/Password'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Signature/Notifications/Severity'
      => 'Shipment::FedEx::WSDL::TrackTypes::NotificationSeverityType',
    'SignatureProofOfDeliveryLetterReply/Notifications' =>
      'Shipment::FedEx::WSDL::TrackTypes::Notification',
    'SendNotificationsReply/Version/Minor' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackRequest/ClientDetail/AccountNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/TransactionDetail/Localization/LanguageCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/AccountNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ShipperAddress/UrbanizationCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/SelectionDetails/SecureSpodAccount' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/Notifications/Message' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/ShipDateRangeBegin' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::date',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/AdditionalMeasures'
      => 'Shipment::FedEx::WSDL::TrackTypes::Measure',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Contact/PagerNumber' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/DeliveryOptionEligibilityDetails'
      => 'Shipment::FedEx::WSDL::TrackTypes::DeliveryOptionEligibilityDetail',
    'TrackRequest/Version/ServiceId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/HarmonizedCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/Version/Intermediate' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::int',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/Address/PostalCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails' =>
      'Shipment::FedEx::WSDL::TrackTypes::TrackDetail',
    'TrackReply/CompletedTrackDetails/TrackDetails/Recipient/CompanyName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/TransactionDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'SignatureProofOfDeliveryFaxReply/Notifications/Code' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/WebAuthenticationDetail/UserCredential/Key' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Events/EventDescription' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxRecipient/Address/City' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterReply/Version' =>
      'Shipment::FedEx::WSDL::TrackTypes::VersionId',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact' =>
      'Shipment::FedEx::WSDL::TrackTypes::Contact',
    'TrackRequest/SelectionDetails/Destination/PostalCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/ClientDetail/Localization/LocaleCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/OriginLocationAddress/City'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsRequest/NotificationDetail/PersonalMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/Commodities/UnitPrice' =>
      'Shipment::FedEx::WSDL::TrackTypes::Money',
    'TrackRequest/TransactionDetail/CustomerTransactionId' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SendNotificationsReply/Packages/Destination/StreetLines' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/TollFreePhoneNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackRequest/ClientDetail/Localization' =>
      'Shipment::FedEx::WSDL::TrackTypes::Localization',
    'SignatureProofOfDeliveryFaxRequest/QualifiedTrackingNumber/Destination/StateOrProvinceCode'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryLetterRequest/Consignee/Contact/PersonName' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'SignatureProofOfDeliveryFaxRequest/FaxSender/Address/UrbanizationCode' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/PackageDimensionalWeight'
      => 'Shipment::FedEx::WSDL::TrackTypes::Weight',
    'SignatureProofOfDeliveryLetterRequest/QualifiedTrackingNumber/AccountNumber'
      => 'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails/TrackDetails/ServiceCommitMessage' =>
      'SOAP::WSDL::XSD::Typelib::Builtin::string',
    'TrackReply/CompletedTrackDetails' =>
      'Shipment::FedEx::WSDL::TrackTypes::CompletedTrackDetail'
};

sub get_class {
    my $name = join '/', @{$_[1]};
    return $typemap_1->{$name};
}

sub get_typemap {
    return $typemap_1;
}

1;

=pod

=encoding UTF-8

=head1 NAME

Shipment::FedEx::WSDL::TrackTypemaps::TrackService

=head1 VERSION

version 3.05

=head1 DESCRIPTION

Typemap created by SOAP::WSDL for map-based SOAP message parsers.

=head1 NAME

Shipment::FedEx::WSDL::TrackTypemaps::TrackService - typemap for TrackService

=head1 AUTHOR

Andrew Baerg <baergaj@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Andrew Baerg.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

__END__


