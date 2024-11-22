import { type UseDocument } from '../../hooks/useDocument';
interface PreviewContextValue {
    url: string;
    mainField: string;
    document: NonNullable<ReturnType<UseDocument>['document']>;
    meta: NonNullable<ReturnType<UseDocument>['meta']>;
    schema: NonNullable<ReturnType<UseDocument>['schema']>;
}
declare const usePreviewContext: <Selected>(consumerName: string, selector: (value: PreviewContextValue) => Selected) => Selected;
declare const ProtectedPreviewPage: () => import("react/jsx-runtime").JSX.Element;
export { ProtectedPreviewPage, usePreviewContext };
