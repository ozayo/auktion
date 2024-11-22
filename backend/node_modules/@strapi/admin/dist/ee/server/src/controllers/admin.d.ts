declare const _default: {
    getProjectType(): Promise<{
        data: {
            isEE: boolean | undefined;
            features: {
                [key: string]: any;
                name: string;
            }[];
            flags: {};
        };
    }>;
    licenseLimitInformation(): Promise<{
        data: {
            enforcementUserCount: any;
            currentActiveUserCount: any;
            permittedSeats: number | null | undefined;
            shouldNotify: boolean;
            shouldStopCreate: boolean;
            licenseLimitStatus: string | null;
            isHostedOnStrapiCloud: boolean;
            features: {
                [key: string]: any;
                name: string;
            }[];
        };
    }>;
};
export default _default;
//# sourceMappingURL=admin.d.ts.map