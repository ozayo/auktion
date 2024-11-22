/**
 * This hook doesn't use a context provider because we fetch directly from the server,
 * this sounds expensive but actually, it's really not. Because we have redux-toolkit-query
 * being a cache layer so if nothing invalidates the cache, we don't fetch again.
 */
import { FormErrors } from '@strapi/admin/strapi-admin';
import { Modules } from '@strapi/types';
import { useGetDocumentQuery } from '../services/documents';
import { ComponentsDictionary } from './useContentTypeSchema';
import type { FindOne } from '../../../shared/contracts/collection-types';
import type { ContentType } from '../../../shared/contracts/content-types';
interface UseDocumentArgs {
    collectionType: string;
    model: string;
    documentId?: string;
    params?: object;
}
type UseDocumentOpts = Parameters<typeof useGetDocumentQuery>[1];
type Document = FindOne.Response['data'];
type Schema = ContentType;
type UseDocument = (args: UseDocumentArgs, opts?: UseDocumentOpts) => {
    /**
     * These are the schemas of the components used in the content type, organised
     * by their uid.
     */
    components: ComponentsDictionary;
    document?: Document;
    meta?: FindOne.Response['meta'];
    isLoading: boolean;
    /**
     * This is the schema of the content type, it is not the same as the layout.
     */
    schema?: Schema;
    schemas?: Schema[];
    validate: (document: Document) => null | FormErrors;
    hasError?: boolean;
};
/**
 * @alpha
 * @public
 * @description Returns a document based on the model, collection type & id passed as arguments.
 * Also extracts its schema from the redux cache to be used for creating a validation schema.
 * @example
 * ```tsx
 * const { id, model, collectionType } = useParams<{ id: string; model: string; collectionType: string }>();
 *
 * if(!model || !collectionType) return null;
 *
 * const { document, isLoading, validate } = useDocument({ documentId: id, model, collectionType, params: { locale: 'en-GB' } })
 * const { update } = useDocumentActions()
 *
 * const onSubmit = async (document: Document) => {
 *  const errors = validate(document);
 *
 *  if(errors) {
 *      // handle errors
 *  }
 *
 *  await update({ collectionType, model, id }, document)
 * }
 * ```
 *
 * @see {@link https://contributor.strapi.io/docs/core/content-manager/hooks/use-document} for more information
 */
declare const useDocument: UseDocument;
/**
 * @internal this hook uses the router to extract the model, collection type & id from the url.
 * therefore, it shouldn't be used outside of the content-manager because it won't work as intended.
 */
declare const useDoc: () => {
    /**
     * These are the schemas of the components used in the content type, organised
     * by their uid.
     */
    components: ComponentsDictionary;
    document?: Modules.Documents.AnyDocument | undefined;
    meta?: import("../../../shared/contracts/collection-types").DocumentMetadata | undefined;
    isLoading: boolean;
    /**
     * This is the schema of the content type, it is not the same as the layout.
     */
    schema?: ContentType | undefined;
    schemas?: ContentType[] | undefined;
    validate: (document: Document) => null | FormErrors;
    hasError?: boolean | undefined;
    collectionType: string;
    model: string;
    id: string | undefined;
};
/**
 * @public
 * @experimental
 * Content manager context hooks for plugin development.
 * Make sure to use this hook inside the content manager.
 */
declare const useContentManagerContext: () => {
    error: import("@reduxjs/toolkit").SerializedError | import("../utils/api").BaseQueryError | undefined;
    isLoading: boolean;
    model: string;
    collectionType: string;
    id: string | undefined;
    slug: string;
    isCreatingEntry: boolean;
    isSingleType: boolean;
    hasDraftAndPublish: boolean;
    components: ComponentsDictionary;
    contentType: ContentType | undefined;
    contentTypes: ContentType[] | undefined;
    form: import("@strapi/admin/strapi-admin").FormContextValue<import("@strapi/admin/strapi-admin").FormValues>;
    layout: {
        error?: import("@reduxjs/toolkit").SerializedError | import("../utils/api").BaseQueryError | undefined;
        isLoading: boolean;
        edit: import("./useDocumentLayout").EditLayout;
        list: import("./useDocumentLayout").ListLayout;
    };
};
export { useDocument, useDoc, useContentManagerContext };
export type { UseDocument, UseDocumentArgs, Document, Schema, ComponentsDictionary };
